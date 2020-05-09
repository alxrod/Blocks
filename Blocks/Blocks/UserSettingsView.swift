//
//  UserSettingsView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 4/13/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct UserSettingsView: View {
    @State var start_time: Date = UserDefaults.standard.object(forKey:"start_time") as? Date ?? Date()
    @State var end_time: Date = UserDefaults.standard.object(forKey:"end_time") as? Date ?? Date().addingTimeInterval(60*60*12)
    @EnvironmentObject var userData: UserData
    var body: some View {
         VStack(alignment: .leading){
            Text("User Settings").font(.system(size:40)).fontWeight(.bold).padding(.leading, 20).padding(.top,40).foregroundColor(.white)
            Form {
                DatePicker("Start Time",selection: Binding(
                    get: {self.start_time},
                    set: { (new_val) in
                        self.start_time = new_val
                        UserDefaults.standard.set(self.start_time, forKey: "start_time")
                    }
                ), displayedComponents: .hourAndMinute)
                
                DatePicker("End Time",selection: Binding(
                    get: {self.end_time},
                    set: { (new_val) in
                        self.end_time = new_val
                        UserDefaults.standard.set(self.end_time, forKey: "end_time")
                    }
                ), displayedComponents: .hourAndMinute)
                
                Button("Enable Notifications") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
    
            }.edgesIgnoringSafeArea(.all)


            
                   
        }.background(Color(UIColor(rgb: 0x5D87A1)))
            .navigationBarTitle(Text("blank"),displayMode: .inline)
            .navigationBarHidden(true)
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView().environmentObject(UserData())
    }
}
