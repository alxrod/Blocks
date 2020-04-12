//
//  PageView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct PageView: View {
    @EnvironmentObject var userData: UserData
    var viewControllers: [UIViewController]  = [UIViewController]()
    
    mutating func setUpViews(envirObj: UserData) {
        self.viewControllers.append(UIHostingController(rootView: ContentView(referenceData: Date().addingTimeInterval(10)).environmentObject(envirObj)))
        self.viewControllers.append(UIHostingController(rootView: HistoryView().environmentObject(envirObj)))
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
        PageView().environmentObject(UserData())
    }
}
