//
//  Block Row.swift
//  Blocks
//
//  Created by Alex Rodriguez on 2/23/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import SwiftUI

struct BlockRow: View {
    @State var block: Block
    @State var tempTest: Bool = false
    var body: some View {
        HStack {
            Toggle(isOn: Binding(
                get: { if (self.block.score > 0.5) {
                        return true
                    } else {
                        return false
                    }
                },
                set: { (newValue) in
                    if (newValue) {
                        self.block.switchRating(newRating: 1)
                    } else {
                        self.block.switchRating(newRating: 0)
                    }
                    print("Updating block data")
                    if let data = UserDefaults.standard.data(forKey: "blocks") {
                        let decoder = PropertyListDecoder()
                        if let decoded = try? decoder.decode([Block].self, from: data) {
                            print("Loaded saved blocks")
                            var blocks = decoded
                            var located = false
                            for (index, block) in blocks.enumerated() {
                                if (block.id == self.block.id) {
                                    blocks[index] = self.block
                                    located = true
                                }
                            }
                            if (located) {
                                UserDefaults.standard.set(try! PropertyListEncoder().encode(blocks), forKey: "blocks")
                            } else {
                                print("No matching block found to save.")
                            }

                        }
                    }
            }
            )) {
            Text(self.block.note)
                .font(.system(size:24))
                .foregroundColor(.white)
                .fontWeight(.semibold)
                Spacer()
            }
            
        }
        .padding(.all)
        .background(Color(UIColor(rgb: block.bg)))
        .cornerRadius(6)
        
        
    }
}

struct BlockRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BlockRow(block: Block(id:1,note:"Walking the dogs",score:1,bg:0x5D87A1, time: Date()))
            BlockRow(block: Block(id:2,note:"Watched TikToks",score:0,bg:0xB13133, time: Date()))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
