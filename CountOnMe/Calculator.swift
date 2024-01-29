//
//  calculator.swift
//  CountOnMe
//
//  Created by Bilal D on 23/01/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    enum Operand: String, CaseIterable {
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case divide = "/"
        case equal = "="
    }
    
    private var elements: [String] = []
    var text: String {
        return elements.joined(separator: " ")
    }
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return elements.contains("=")
    }
    
    
    func appendElement(_ value: String) {
        if expressionHaveResult {
            elements = []
        }
        if let lastValue = elements.last {
            if let operand =
            Operand(rawValue: lastValue),
               Operand.allCases.contains(operand) {
                
            } else {
                elements.removeLast()
                elements.append(lastValue.appending(value))
            }
        } else {
            elements.append(value)
        }
        
    }
    
    func appendOperand(_ operand: Operand) {
        if canAddOperator {
            appendElement(operand.rawValue)
        }
    }
}
