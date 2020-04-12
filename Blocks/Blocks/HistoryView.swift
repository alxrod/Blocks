//
//  HistoryView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var userData: UserData
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
                ForEach(self.userData.blocks, id: \.id) { block in
                    BlockRow(note: block.note, bg: Color(UIColor(rgb: 0x5D87A1)))
                }
                
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
