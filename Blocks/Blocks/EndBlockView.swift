//
//  EndBlockView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct EndBlockView: View {
    @State private var blockNote = ""
    
    var body: some View {
        VStack {
                Text("What'd you do?")
                    .font(.system(size:50))
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                HStack {
                    TextField("Hope it was productive!", text: $blockNote)
                        .frame(width: 300, height: 35, alignment: .center)
                        .padding(.all, 10)
                        .font(.system(size:20))
                        .background(Color(.white))
                        .cornerRadius(10)
                }
            
                Text("3:53")
                     .font(.system(size:65))
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
            
                
        }
            .frame(minWidth: 0, maxWidth:
            .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(UIColor(rgb: 0x94AD58)))
            .edgesIgnoringSafeArea(.all)
    }
}

struct EndBlockView_Previews: PreviewProvider {
    static var previews: some View {
        EndBlockView()
    }
}
