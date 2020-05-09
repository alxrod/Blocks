//
//  ContentView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var bgGrad = createbgGrad(prod: 0.5)
    @State var nowDate: Date = Date()
    @State var isScreenActive: Bool = false
    @State var needToReset = false
    @State var referenceData: Date = Date()
    @State var firstLoad = true
    var period_length = Double(60*60)
    
    
    @EnvironmentObject var userData: UserData
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
                self.nowDate=Date()
                let diff = Calendar.current.dateComponents([.minute, .second], from: self.nowDate, to: self.referenceData)
                // print ("Clocking with \(diff)")
            if ((diff.minute == 0 && diff.second == 0) || self.nowDate>self.referenceData) {
                    print("Timer ended!")
                    timer.invalidate()
                    self.needToReset = true
                    self.isScreenActive = true
                }
            }
        }
    init(referenceData: Date) {
        self.referenceData = referenceData
        
    }
        
    func recalcBg() {
        var total_score = 0.0
        for block in self.userData.blocks {
            total_score += block.score
        }
        let ratio = total_score/Double(self.userData.blocks.count)
        bgGrad = createbgGrad(prod: 1-CGFloat(ratio))
        print("New Ratio")
        print(ratio)
    }

    
    func countDownString(date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.day,.hour,.minute,.second], from: self.nowDate, to: date)
        return String(format: "%02d:%02d",
                        components.minute ?? 00,
                        components.second ?? 00)
    }
    
    func queueNotificationTimer(time: Double) {
        let content = UNMutableNotificationContent()
        content.title = "The Period is Over!"
        content.subtitle = "Tell me what you did"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)

    }
    
    func startBlock() {
        self.firstLoad = false
        self.nowDate = Date()
        self.referenceData = Date().addingTimeInterval(self.period_length)
        self.queueNotificationTimer(time: self.period_length)
    }
    var body: some View {
            VStack {
                Text(countDownString(date: referenceData))
                    .font(.system(size:72))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onAppear(perform: {
                        self.userData.UpdateGradResp = {() -> Void in
                            print("Wow this worked?")
                            self.recalcBg()
                        }
                        if (self.needToReset == true || self.firstLoad == true) {
                            let startTime = UserDefaults.standard.object(forKey:"start_time") as? Date ?? Date()
                            let sH = Calendar.current.component(.hour, from: startTime)
                            let sM = Calendar.current.component(.minute, from: startTime)
                            let endTime = UserDefaults.standard.object(forKey:"end_time") as? Date ?? Date()
                            let eH = Calendar.current.component(.hour, from: endTime)
                            let eM = Calendar.current.component(.minute, from: endTime)
                            
                            let adj_start =  Calendar.current.date(bySettingHour: sH, minute: sM, second: 0, of: Date())!
                            let adj_end =  Calendar.current.date(bySettingHour: eH, minute: eM, second: 0, of: Date())!
                            if (Date() > adj_start && Date() < adj_end) {
                                self.startBlock()
                                let _ = self.timer
                            } else {
                                print("You're in off hours")
                            }
        
                            
                        }
                        
                    })
                NavigationLink(destination: EndBlockView().environmentObject(userData), isActive: $isScreenActive) {
                    Spacer()
                }
                    
            
            }
                .frame(minWidth: 0, maxWidth:
                .infinity, minHeight: 0, maxHeight: .infinity)
                .background(LinearGradient(gradient: bgGrad, startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.all)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving to the foreground")
                     if (self.needToReset == true || self.firstLoad == true) {
                        let startTime = UserDefaults.standard.object(forKey:"start_time") as? Date ?? Date()
                        let sH = Calendar.current.component(.hour, from: startTime)
                        let sM = Calendar.current.component(.minute, from: startTime)
                        let endTime = UserDefaults.standard.object(forKey:"end_time") as? Date ?? Date()
                        let eH = Calendar.current.component(.hour, from: endTime)
                        let eM = Calendar.current.component(.minute, from: endTime)
                                               
                        var adj_start =  Calendar.current.date(bySettingHour: sH, minute: sM, second: 0, of: Date())!
                        var adj_end =  Calendar.current.date(bySettingHour: eH, minute: eM, second: 0, of: Date())!
                        if (Date() > adj_start && Date() < adj_end) {
                            self.startBlock()
                            let _ = self.timer
                        } else {
                            print("You're in off hours")
                        }
                           
                    }


            
            }.onAppear() {
                self.recalcBg()
            }
    }
}

func createbgGrad(prod: CGFloat) -> Gradient {
    let unprod = prod+0.2
    let stop1 = Gradient.Stop(color: Color(UIColor(rgb: 0xB13133)), location: prod-0.2)
    let stop2 = Gradient.Stop(color: Color(UIColor(rgb: 0x5D87A1)), location: unprod)
    let bgGrad = Gradient(stops: [stop1,stop2])
    
    return bgGrad
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(referenceData: Date().addingTimeInterval(10.0)).environmentObject(UserData())
    }
}
