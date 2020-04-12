//
//  UserData.swift
//  Blocks
//
//  Created by Alex Rodriguez on 4/11/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    var raw_data: Data? = UserDefaults.standard.data(forKey: "blocks")
    @Published var blocks: [Block] {
        didSet {
            print("Writing User Default data")
            UserDefaults.standard.set(try! PropertyListEncoder().encode(self.blocks), forKey: "blocks")
        }
    }
    
    init () {
        print("Initializing user info")
        if let data = self.raw_data {
            do {
                try blocks = PropertyListDecoder().decode([Block].self, from: data)
                print("Successfully decoded blocks from UserDefaults as: ")
                print(self.blocks)
            } catch {
                print("Could not decode block data from UserDefaults")
                self.blocks = [Block]()
            }
        } else {
            self.blocks = [Block]()
        }
    }
}
