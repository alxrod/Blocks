//
//  PageView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct PageView: View {
    
    var viewControllers = [
        UIHostingController(rootView: ContentView(referenceData: Date().addingTimeInterval(10))),
        UIHostingController(rootView: HistoryView()),
    ]
    
    init() {
        
    }
    var body: some View {
        NavigationView {
            PageViewController(controllers: viewControllers).edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
    }
}

//func pipeViews(view1: View, view2: View) -> [View] {
//    let views = [view1, view2]
//    return views
//}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
