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
        let baseNumber = 4
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
        calculator.appendElement("+")
        calculator.appendElement("3")
        calculator.appendElement("*")
        calculator.appendElement("4")
        let expectedResult = "14"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testSubstractionBeforeMultiplication() throws {
        let calculator = Calculator()
        calculator.appendElement("10")
        calculator.appendElement("-")
        calculator.appendElement("2")
        calculator.appendElement("*")
        calculator.appendElement("3")
        let expectedResult = "4"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testSubstractionBeforeDivision() throws {
        let calculator = Calculator()
        calculator.appendElement("30")
        calculator.appendElement("-")
        calculator.appendElement("20")
        calculator.appendElement("/")
        calculator.appendElement("5")
        let expectedResult = "26"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAdditionBeforeDivision() throws {
        let calculator = Calculator()
        calculator.appendElement("10")
        calculator.appendElement("+")
        calculator.appendElement("20")
        calculator.appendElement("/")
        calculator.appendElement("5")
        let expectedResult = "14"
        let result = try calculator.calculate()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDivisionByZero() {
        let calculator = Calculator()
        
        calculator.appendElement("10")
        calculator.appendElement("/")
        calculator.appendElement("0")
        
        XCTAssertThrowsError(try calculator.calculate()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .zeroDivision, "Une division par zéro devrait lever une erreur .zeroDivision")
        }
    }
    
    
}
