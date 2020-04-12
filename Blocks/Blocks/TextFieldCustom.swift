//
//  TextFieldDone.swift
//  Blocks
//
//  Created by Alex Rodriguez on 4/5/20.
//  Copyright © 2020 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftUI

struct TextFieldCustom: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    let returnVal: UIReturnKeyType
    let tag: Int
    let placeholder: String
    @Binding var text: String
    @Binding var isfocusAble: [Bool]
    let responseAction: () -> Void
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = self.keyboardType
        textField.returnKeyType = self.returnVal
        textField.tag = self.tag
        textField.placeholder = self.placeholder
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no

        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if isfocusAble[tag] {
            uiView.becomeFirstResponder()
        } else {
//            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldCustom
        
        init(_ textfield: TextFieldCustom) {
            self.parent = textfield
        }
        
        func updatefocus(textfield: UITextField) {
            textfield.becomeFirstResponder()
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.parent.text = textField.text ?? ""
            print("User entered " + self.parent.text)
            self.parent.responseAction()
            return true
        }
    }
    
}
