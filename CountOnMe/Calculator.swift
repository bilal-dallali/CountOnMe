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
        case cannotAddOperator
        
        var errorDescription: String? {
            switch self {
            case .invalidExpression:
                return "Erreur : Expression invalide"
            case .zeroDivision:
                return "Erreur : Division par zéro"
            case .unavailableResult:
                return "Erreur : Résultat invalide"
            case .cannotAddOperator:
                return "Erreur : un opérateur est déjà mit"
            }
        }
    }
    
    func calculate() throws -> String {
        
        
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

    private func isOperator(_ element: String) -> Bool {
        return ["+", "-", "*", "/"].contains(element)
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
    
    @discardableResult func addNumber(_ value: String) -> String {
        if expressionHaveResult {
            // Si le résultat est affiché, commencez une nouvelle expression
            clear()
        }
        
        // Deal with a negative numner at the beginning of the expression
        
        if elements.isEmpty && value.starts(with: "-") {
            elements.append(value)
        } else if let lastValue = elements.last {
            if let operand = Operand(rawValue: lastValue), Operand.allCases.contains(operand) {
                elements.append(value)
            } else {
                elements.removeLast()
                elements.append(lastValue.appending(value))
            }
        } else {
            elements.append(value)
        }
//        if let lastValue = elements.last {
//            if let operand =
//                Operand(rawValue: lastValue),
//               Operand.allCases.contains(operand) {
//                elements.append(value)
//            } else {
//                elements.removeLast()
//                elements.append(lastValue.appending(value))
//            }
//        } else {
//            elements.append(value)
//        }
        return text
    }
    
    @discardableResult func addOperand(_ operand: Operand) throws -> String {
        if canAddOperator {
            elements.append(operand.rawValue)
            return text
        } else {
            throw CalculatorError.cannotAddOperator
        }
    }
    
    private var elements: [String] = []
    var text: String {
        return elements.joined(separator: " ")
    }
    // Error check computed variables
    var expressionIsCorrect: Bool {
        // Allow an expression starting with a negative number followed by an operator
        if elements.count >= 2 && elements.first == "-" && isOperator(elements[1]) {
            return true
        }
        
        // Check if the last element is not an operator
        return !isOperator(elements.last ?? "")
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        //return elements.last != "+" && elements.last != "-"
        guard let lastElement = elements.last else { return true }
        return !isOperator(lastElement)
    }
    
    private func isOperator(_ element: String) -> Bool {
        return ["+", "-", "*", "/"].contains(element)
    }
    
    var expressionHaveResult: Bool {
        return elements.contains(Operand.equal.rawValue)
    }
    
    func clear() {
        elements = []
    }
}
