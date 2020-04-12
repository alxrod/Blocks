//
//  EndBlockView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct EndBlockView: View {
    @State var note = ""
    @State var focused: [Bool] = [false]
    @State var nowDate: Date = Date()
    @State var backgroundColor = 0x94AD58
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let referenceDate: Date = Date().addingTimeInterval(10.0)
    
    var timer: Timer {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.nowDate=Date()
            let diff = Calendar.current.dateComponents([.minute, .second], from: self.nowDate, to: self.referenceDate)
            if (diff.minute == 0 && diff.second == 0) {
                print("Timer ended!")
                timer.invalidate()
                self.backgroundColor = 0xB13133
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
                Text("What'd you do?")
                    .font(.system(size:50))
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                HStack {
                    TextFieldCustom(keyboardType: .default, returnVal: .done, tag: 0,placeholder:"Hope it was productive", text: self.$note, isfocusAble: self.$focused) {
                        let block: Block = Block(id: self.userData.blocks.count, note: self.note, score: 1, bg: 0xB13133,time:Date())
                        print("Adding block:")
                        print(block)
                        self.userData.blocks.append(block)
//                        print("Test from here")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                        .frame(width: 300, height: 35, alignment: .center)
                        .padding(.all, 10)
                        .font(.system(size:20))
                        .background(Color(.white))
                        .cornerRadius(10)
         
                }
            
            Text(countDownString(date: self.referenceDate))
                     .font(.system(size:65))
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
                     .onAppear(perform: {
                         let _ = self.timer
                     })
//
                
        }
            .frame(minWidth: 0, maxWidth:
            .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(UIColor(rgb: self.backgroundColor)))
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
    }
}

struct EndBlockView_Previews: PreviewProvider {
    static var previews: some View {
        EndBlockView()
    }
}
