//
//  HistoryView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Progress").font(.system(size:40)).fontWeight(.bold).padding(.leading, 20).padding(.top,40)
            List {
                    BlockRow(bgColor: Color(UIColor(rgb: 0x5D87A1)))
                    BlockRow(bgColor: Color(UIColor(rgb: 0xB13133)))
                    BlockRow(bgColor: Color(UIColor(rgb: 0x5D87A1)))
                    BlockRow(bgColor: Color(UIColor(rgb: 0xB13133)))
                    BlockRow(bgColor: Color(UIColor(rgb: 0x5D87A1)))
                    BlockRow(bgColor: Color(UIColor(rgb: 0xB13133)))
            }
        }
        .navigationBarTitle(Text("blank"),displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
