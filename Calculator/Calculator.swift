//
//  Calculator.swift
//  Calculator
//
//  Created by Dasu on 2021/10/20.
//

import Foundation

struct Calculator {
    
    var currentInput: String = "0"
    
    var isTapDouble: Bool = false
    
    mutating func addInput(_ text: String?) {
        guard let text = text else {
            return
        }
        
        if text == ".", isTapDouble {
            return
        }
        
        if currentInput == "0" {
            currentInput = text
            if text == "." && !isTapDouble {
                isTapDouble = true
                currentInput = "0."
            }
        } else {
            let double = Double(currentInput.replacingOccurrences(of: ",", with: "") + text) ?? 0
            let newText = double.changNumber
            
            if text == "." && !isTapDouble {
                isTapDouble = true
                currentInput = newText + "."
            } else {
                currentInput = newText
            }
        }
    }
}
