//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    func testSuccessfulAddition() throws {
        let calculator = Calculator()
        calculator.addNumber("4")
        try calculator.addOperand(.plus)
        calculator.addNumber("8")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "12")
    }
    
    func testSuccessfulSubstraction() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.addNumber("16")
        try calculator.addOperand(.minus)
        calculator.addNumber("6")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "10")
    }
    
    func testSuccessfulNegativeResultSubstraction() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.addNumber("16")
        try calculator.addOperand(.minus)
        calculator.addNumber("20")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "-4")
    }
    
    func testSuccessfulMultiplication() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.addNumber("4")
        try calculator.addOperand(.multiply)
        calculator.addNumber("8")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "32")
    }
    
    func testSuccessfulDivision() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.addNumber("100")
        try calculator.addOperand(.divide)
        calculator.addNumber("4")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "25")
    }
    
    func testAdditionBeforeMultiplication() throws {
        let calculator = Calculator()
        calculator.addNumber("2")
        try calculator.addOperand(.plus)
        calculator.addNumber("3")
        try calculator.addOperand(.multiply)
        calculator.addNumber("4")
        let expectedResult = "14"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testSubstractionBeforeMultiplication() throws {
        let calculator = Calculator()
        calculator.addNumber("10")
        try calculator.addOperand(.minus)
        calculator.addNumber("2")
        try calculator.addOperand(.multiply)
        calculator.addNumber("3")
        let expectedResult = "4"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testSubstractionBeforeDivision() throws {
        let calculator = Calculator()
        calculator.addNumber("30")
        try calculator.addOperand(.minus)
        calculator.addNumber("20")
        try calculator.addOperand(.divide)
        calculator.addNumber("5")
        let expectedResult = "26"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAdditionBeforeDivision() throws {
        let calculator = Calculator()
        calculator.addNumber("10")
        try calculator.addOperand(.plus)
        calculator.addNumber("20")
        try calculator.addOperand(.divide)
        calculator.addNumber("5")
        let expectedResult = "14"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDivisionByZero() throws {
        let calculator = Calculator()
        
        calculator.addNumber("10")
        try calculator.addOperand(.divide)
        calculator.addNumber("0")
        
        XCTAssertThrowsError(try calculator.calculate()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .zeroDivision, "Une division par zéro devrait lever une erreur .zeroDivision")
        }
    }
    
    func testCannotAddOperator() throws {
        let calculator = Calculator()
        calculator.addNumber("10")
        try calculator.addOperand(.plus)
        //try calculator.addOperand(.multiply)
        
        XCTAssertThrowsError(try calculator.addOperand(.multiply)) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .cannotAddOperator, "Adding two operators should generate an error")
        }
    }
    
    func testUnavalaibleResult() throws {
        let calculator = Calculator()
        XCTAssertThrowsError(try calculator.calculate()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .unavailableResult, "An empty expression or indeterminate form should generate an unavailableResult error.")
        }
    }
    
    func testInvalidExpression() throws {
        let calculator = Calculator()
        calculator.addNumber("4")
        try calculator.addOperand(.plus)
        
        XCTAssertThrowsError(try calculator.calculate()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .invalidExpression, "An expression ending with an operator should generate an invalidExpression error.")
        }
    }

    func testClear() throws {
        let calculator = Calculator()
        calculator.addNumber("4")
        try calculator.addOperand(.plus)
        calculator.addNumber("8")
        XCTAssertEqual(calculator.text, "4 + 8")
        calculator.clear()
        XCTAssertEqual(calculator.text, "")
    }
    
    func testAddingNegativeNumberAtStart() throws {
        let calculator = Calculator()
        calculator.addNumber("-5")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "-5", "Le calcul devrait pouvoir commencer par un nombre négatif.")
    }
    
    func testOperationNegativeNumberAtStart() throws {
        let calculator = Calculator()
        calculator.addNumber("-5")
        try calculator.addOperand(.minus)
        calculator.addNumber("75")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "-80")
    }
    
    func testOperationNegativeNumberMultiplyAtStart() throws {
        let calculator = Calculator()
        calculator.addNumber("-5")
        try calculator.addOperand(.multiply)
        calculator.addNumber("8")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "-40")
    }
    
    func testOperationNegativeNumberDivideAtStart() throws {
        let calculator = Calculator()
        calculator.addNumber("-40")
        try calculator.addOperand(.divide)
        calculator.addNumber("8")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "-5")
    }

}
