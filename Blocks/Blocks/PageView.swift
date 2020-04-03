//
//  PageView.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    var body: some View {
        PageViewController(controllers: viewControllers).edgesIgnoringSafeArea(.all)
        
    }
}

func pipeViews(view1: View, view2: View) -> [View] {
    let views = [view1, view2]
    return views
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([ContentView(),HistoryView()])
    }
}
