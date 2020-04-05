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
    let bgGrad = createbgGrad(prod: 0.6)
    @State var nowDate: Date = Date()
    @State var isScreenActive: Bool = false
    @State var needToReset = false
    @State var referenceData: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
                self.nowDate=Date()
                let diff = Calendar.current.dateComponents([.minute, .second], from: self.nowDate, to: self.referenceData)
                // print ("Clocking with \(diff)")
                if (diff.minute == 0 && diff.second == 0) {
                    print("Timer ended!")
                    timer.invalidate()
                    self.needToReset = true
                    self.isScreenActive = true
                }
            }
        }
    
        

    
    func countDownString(date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.day,.hour,.minute,.second], from: self.nowDate, to: date)
        return String(format: "%02d:%02d",
                        components.minute ?? 00,
                        components.second ?? 00)
    }
    
    var body: some View {
            VStack {
                Text(countDownString(date: referenceData))
                    .font(.system(size:72))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onAppear(perform: {
                        if (self.needToReset == true) {
                            self.nowDate = Date()
                            self.referenceData = Date().addingTimeInterval(10.0)
                        }
                        let _ = self.timer
                    })
                NavigationLink(destination: EndBlockView(), isActive: $isScreenActive) {
                    Spacer()
                }
                    
            
            }
                .frame(minWidth: 0, maxWidth:
                .infinity, minHeight: 0, maxHeight: .infinity)
                .background(LinearGradient(gradient: bgGrad, startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.all)


            
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
        ContentView(referenceData: Date().addingTimeInterval(10.0))
    }
}
