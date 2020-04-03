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
    var body: some View {
            VStack {
                Text("26:32")
                    .font(.system(size:72))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
            
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
        ContentView()
    }
}
