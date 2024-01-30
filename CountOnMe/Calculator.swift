//
//  calculator.swift
//  CountOnMe
//
//  Created by Bilal D on 23/01/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    func calculate(elements: [String]) -> String {
            var operationsToReduce = elements

            // Première passe pour les multiplications et divisions
            while let index = operationsToReduce.firstIndex(where: { $0 == "*" || $0 == "/" }) {
                guard index > 0, index < operationsToReduce.count - 1,
                      let left = Double(operationsToReduce[index - 1]),
                      let right = Double(operationsToReduce[index + 1]) else {
                    return "Erreur : Expression invalide"
                }

                if operationsToReduce[index] == "/" && right == 0 {
                    return "Erreur : Division par zéro"
                }

                let result = operationsToReduce[index] == "*" ? left * right : left / right
                operationsToReduce.replaceSubrange(index-1...index+1, with: [String(result)])
            }

            // Deuxième passe pour les additions et soustractions
            while let index = operationsToReduce.firstIndex(where: { $0 == "+" || $0 == "-" }) {
                guard index > 0, index < operationsToReduce.count - 1,
                      let left = Double(operationsToReduce[index - 1]),
                      let right = Double(operationsToReduce[index + 1]) else {
                    return "Erreur : Expression invalide"
                }

                let result = operationsToReduce[index] == "+" ? left + right : left - right
                operationsToReduce.replaceSubrange(index-1...index+1, with: [String(result)])
            }

            return operationsToReduce.first ?? "Erreur : Résultat non disponible"
        }
    
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
    
    
//    func appendElement(_ value: String) {
//        if expressionHaveResult {
//            elements = [value]
//        } else if let last = elements.last, Operand(rawValue: last) == nil {
//            elements[elements.count - 1] = "\(last)\(value)"
//        } else {
//            elements.append(value)
//        }
//    }
    
//    func appendOperand(_ operand: Operand) {
//        if canAddOperator {
//            appendElement(operand.rawValue)
//        }
//    }
    
    func clear() {
        elements = []
    }
    
    
    
}
