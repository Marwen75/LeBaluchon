//
//  RateTestCase.swift
//  LeBaluchonTests
//
//  Created by Marwen Haouacine on 26/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import XCTest

@testable import LeBaluchon

class RateTestCase: XCTestCase {
    
    var rate: Rate!
    
    override func setUp() {
        super.setUp()
        rate = Rate(rates: ["USD": 1.181607])
    }
    override func tearDown() {
        rate = nil
        super.tearDown()
    }
    // Testing the calculate fonction of Rate
    func testRateCalculateFunctionShouldReturnCorrectResult() {
        let result = rate.calculate(amount: 1)
        XCTAssertEqual(result, 1.181607)
    }
    
    func testRateCalculateFunctionReturnZeroIfNoRatesCameBack() {
        rate = Rate(rates: [String: Double]())
        let result = rate.calculate(amount: 1)
        XCTAssertEqual(result, 0.00)
    }
    
}
