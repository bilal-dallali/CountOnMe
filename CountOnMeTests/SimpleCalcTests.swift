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


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
