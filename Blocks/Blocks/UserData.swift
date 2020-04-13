//
//  UserData.swift
//  Blocks
//
//  Created by Alex Rodriguez on 4/11/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var blocks = [Block]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        print("Initializing user info")
        if let data = UserDefaults.standard.data(forKey: "blocks") {
            print("Found something saved at least")
            let decoder = PropertyListDecoder()
            if let decoded = try? decoder.decode([Block].self, from: data) {
                print("Loaded saved blocks")
                self.blocks = decoded
            }
        }
        
        self.$blocks
            .dropFirst()
            .sink { (blocks: [Block]) in
                print("Trying to save on the user side")
                print(blocks)
                UserDefaults.standard.set(try! PropertyListEncoder().encode(blocks), forKey: "blocks")
            }.store(in: &cancellables)
        
    }
}
