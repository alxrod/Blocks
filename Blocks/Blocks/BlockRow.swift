//
//  Block Row.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct BlockRow: View {
    let note: String
    var bg: Color
    var body: some View {
        HStack {
            Text(self.note)
            .font(.system(size:24))
            .foregroundColor(.white)
            .fontWeight(.semibold)
            Spacer()
        }
        .padding(.all)
        .background(bg)
        .cornerRadius(6)
        
        
    }
}

struct BlockRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BlockRow(note:"Walked the dogs", bg: Color(UIColor(rgb: 0x5D87A1)))
            BlockRow(note: "Watched fishing videos", bg: Color(UIColor(rgb: 0xB13133)))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
