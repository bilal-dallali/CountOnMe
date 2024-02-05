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
        try calculator.addOperand(.plus)
        calculator.appendElement("4")
        let result = try calculator.calculate()
        XCTAssertEqual(result, "25")
    }

}
