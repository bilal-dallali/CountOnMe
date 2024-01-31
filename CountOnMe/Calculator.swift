//
//  calculator.swift
//  CountOnMe
//
//  Created by Bilal D on 23/01/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    enum CalculatorError: CustomNSError, LocalizedError {
        case invalidExpression
        case zeroDivision
        case unavailableResult
        
        var errorDescription: String? {
            switch self {
            case .invalidExpression:
                return "Erreur : Expression invalide"
            case .zeroDivision:
                return "Erreur : Division par zéro"
            case .unavailableResult:
                return "Erreur : Résultat invalide"
            }
        }
    }
    
    func calculate(elements: [String]) throws -> String {
        var operationsToReduce = elements
        
        // Traitez d'abord les multiplications et divisions
        while let index = operationsToReduce.firstIndex(where: { $0 == "*" || $0 == "/" }) {
            guard index > 0, index < operationsToReduce.count - 1,
                  let left = Double(operationsToReduce[index - 1]),
                  let right = Double(operationsToReduce[index + 1]) else {
                throw CalculatorError.invalidExpression
                //return "Erreur : Expression invalide"
            }
            
            if operationsToReduce[index] == "/" && right == 0 {
//                return "Erreur : Division par zéro"
                throw CalculatorError.zeroDivision
            }
            
            let result = operationsToReduce[index] == "*" ? left * right : left / right
            operationsToReduce.replaceSubrange(index-1...index+1, with: [formatResult(result)])
        }
        
        // Ensuite, traitez les additions et soustractions
        while let index = operationsToReduce.firstIndex(where: { $0 == "+" || $0 == "-" }) {
            guard index > 0, index < operationsToReduce.count - 1,
                  let left = Double(operationsToReduce[index - 1]),
                  let right = Double(operationsToReduce[index + 1]) else {
                throw CalculatorError.invalidExpression
            }
            
            let result = operationsToReduce[index] == "+" ? left + right : left - right
            operationsToReduce.replaceSubrange(index-1...index+1, with: [formatResult(result)])
        }
        
        guard let value = operationsToReduce.first else { throw CalculatorError.unavailableResult }
        return value
    }
    
    // Fonction pour formater le résultat
    func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)  // Pas de partie décimale si le résultat est un entier
        } else {
            return String(result)  // Conservez la partie décimale si nécessaire
        }
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
        return elements.last != Operand.plus.rawValue && elements.last != Operand.minus.rawValue
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return elements.contains(Operand.equal.rawValue)
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
