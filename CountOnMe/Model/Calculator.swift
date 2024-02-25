//
//  calculator.swift
//  CountOnMe
//
//  Created by Bilal D on 23/01/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    // Custom errors for the calculator
    enum CalculatorError: CustomNSError, LocalizedError {
        case invalidExpression
        case zeroDivision
        case unavailableResult
        case cannotAddOperator
        
        // Provide a user-friendly error message
        var errorDescription: String? {
            switch self {
            case .invalidExpression:
                return "Error : Invalid expression"
            case .zeroDivision:
                return "Error : Division by zero"
            case .unavailableResult:
                return "Error : Invalid result"
            case .cannotAddOperator:
                return "Error : An operator is already set"
            }
        }
    }
    
    // Main calculation function
    func calculate() throws -> String {
        var operationsToReduce = elements
        
        // Handle negative numbers at the beginning of the expression
        if operationsToReduce.first == "-", operationsToReduce.count >= 2, let number = Double(operationsToReduce[1]) {
            // Convert the following number to negative
            operationsToReduce[1] = String(-number)
            // Remove the initial "-"
            operationsToReduce.removeFirst()
        }

        // First, process multiplications and divisions
        while let index = operationsToReduce.firstIndex(where: { $0 == "*" || $0 == "/" }) {
            guard index > 0, index < operationsToReduce.count - 1,
                  let left = Double(operationsToReduce[index - 1]),
                  let right = Double(operationsToReduce[index + 1]) else {
                throw CalculatorError.invalidExpression
            }
            
            if operationsToReduce[index] == "/" && right == 0 {
                throw CalculatorError.zeroDivision
            }
            
            let result = operationsToReduce[index] == "*" ? left * right : left / right
            operationsToReduce.replaceSubrange(index-1...index+1, with: [formatResult(result)])
        }
        
        // Then, process additions and subtractions
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
    
    // Function to format the result
    func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            // No decimal part if the result is an integer
            return String(format: "%.0f", result)
        } else {
            // Keep the decimal part if necessary
            return String(result)
        }
    }
    
    // Operand
    enum Operand: String, CaseIterable {
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case divide = "/"
        case equal = "="
    }
    
    // Add a number to the expression
    @discardableResult func addNumber(_ value: String) -> String {
        if expressionHaveResult {
            // If a result is displayed start a new expression
            clear()
        }
        
        // Handle with a negative numner at the beginning of the expression
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
        return text
    }
    
    // Function to add an operand to the expression
    @discardableResult func addOperand(_ operand: Operand) throws -> String {
        if canAddOperator {
            elements.append(operand.rawValue)
            return text
        } else {
            throw CalculatorError.cannotAddOperator
        }
    }
    
    // Storage for the element of the expression
    private var elements: [String] = []
    
    // Computed property to get the text representation of the expression
    var text: String {
        return elements.joined(separator: " ")
    }
    
    // Computed properties to check various conditions
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
    
    // Clear the current expression
    func clear() {
        elements = []
    }
}
