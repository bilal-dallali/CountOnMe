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
        calculator.appendElement("4")
        try calculator.addOperand(.plus)
        calculator.appendElement("8")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "12")
    }
    
    func testSuccessfulSubstraction() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.appendElement("16")
        try calculator.addOperand(.minus)
        calculator.appendElement("6")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "10")
    }
    
    func testSuccessfulNegativeResultSubstraction() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.appendElement("16")
        try calculator.addOperand(.minus)
        calculator.appendElement("20")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "-4")
    }
    
    func testSuccessfulMultiplication() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.appendElement("4")
        try calculator.addOperand(.multiply)
        calculator.appendElement("8")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "32")
    }
    
    func testSuccessfulDivision() throws {
        //let baseNumber = 4
        let calculator = Calculator()
        calculator.appendElement("100")
        try calculator.addOperand(.divide)
        calculator.appendElement("4")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "25")
    }
    
    func testAdditionBeforeMultiplication() throws {
        let calculator = Calculator()
        calculator.appendElement("2")
        try calculator.addOperand(.plus)
        calculator.appendElement("3")
        try calculator.addOperand(.multiply)
        calculator.appendElement("4")
        let expectedResult = "14"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testSubstractionBeforeMultiplication() throws {
        let calculator = Calculator()
        calculator.appendElement("10")
        try calculator.addOperand(.minus)
        calculator.appendElement("2")
        try calculator.addOperand(.multiply)
        calculator.appendElement("3")
        let expectedResult = "4"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testSubstractionBeforeDivision() throws {
        let calculator = Calculator()
        calculator.appendElement("30")
        try calculator.addOperand(.minus)
        calculator.appendElement("20")
        try calculator.addOperand(.divide)
        calculator.appendElement("5")
        let expectedResult = "26"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAdditionBeforeDivision() throws {
        let calculator = Calculator()
        calculator.appendElement("10")
        try calculator.addOperand(.plus)
        calculator.appendElement("20")
        try calculator.addOperand(.divide)
        calculator.appendElement("5")
        let expectedResult = "14"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDivisionByZero() throws {
        let calculator = Calculator()
        
        calculator.appendElement("10")
        try calculator.addOperand(.divide)
        calculator.appendElement("0")
        
        XCTAssertThrowsError(try calculator.calculate()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .zeroDivision, "Une division par zéro devrait lever une erreur .zeroDivision")
        }
    }
    
    func testCannotAddOperator() throws {
        let calculator = Calculator()
        calculator.appendElement("10")
        try calculator.addOperand(.plus)
        //try calculator.addOperand(.multiply)
        
        XCTAssertThrowsError(try calculator.addOperand(.multiply)) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .cannotAddOperator, "Rajouter deux opérateur à la suite va générer une erreur")
        }
    }
    
    func testClear() throws {
        let calculator = Calculator()
        calculator.appendElement("4")
        try calculator.addOperand(.plus)
        calculator.appendElement("8")
        XCTAssertEqual(calculator.text, "4 + 8")
        calculator.clear()
        XCTAssertEqual(calculator.text, "")
    }
    
}
