//
//  StringTests.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest
import TDCore

class StringTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testWhiteSpace() {
        
        let string = "\n\n \t  Hello   \n\n \t"
        let trimmed = "Hello"
        
        var mutString = string
        mutString.trimWhitespace()
        
        XCTAssertEqual(trimmed, string.whitespaceTrimmedString())
        XCTAssertEqual(trimmed, mutString)
    }
}
