//
//  Block.swift
//  Blocks
//
//  Created by Alex Rodriguez on 4/11/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import Foundation

struct Block: Hashable, Codable, Identifiable {
    var id: Int
    var note: String
    var score: Double
    var bg: Int
    var time: Date
}
