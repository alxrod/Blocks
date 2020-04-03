//
//  Block Row.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct BlockRow: View {
    let bgColor: Color
    var body: some View {
        HStack {
            Text("Walked the Dog")
            .font(.system(size:24))
            .foregroundColor(.white)
            .fontWeight(.semibold)
            Spacer()
        }
        .padding(.all)
        .background(bgColor)
        .cornerRadius(6)
        
        
    }
}

struct BlockRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BlockRow(bgColor: Color(UIColor(rgb: 0x5D87A1)))
            BlockRow(bgColor: Color(UIColor(rgb: 0xB13133)))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
