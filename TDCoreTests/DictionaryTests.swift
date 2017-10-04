//
//  DictionaryTests.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest

import TheDistanceCore

class DictionaryTests: XCTestCase {

    let nums = [1: 1, 2: 2, 3: 3, 4: 4, 10:10]
    
    let squares = [1: 1, 2: 4, 3: 9, 4: 16, 10: 100]
    
    let cubes = [1: 1, 2: 8, 3: 27, 4: 64, 5: 125]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMapValues() {
        
        XCTAssertEqual(squares, nums.mapValues({ $0 * $0 }))
    }
    
    func testMerge() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        var toOverwrite = nums

        cubes.forEach { (arg) in let (k, v) = arg; toOverwrite[k] = v }
        
        XCTAssertEqual(toOverwrite, [1: 1, 2: 8, 3: 27, 4: 64, 5: 125, 10:10])
    }
    
    func testTupleInit() {
        let strings = ["1": "1", "2": "2", "3": "3", "4": "4", "10":"10"]
        
        let stringElements = nums.map({ ("\($0.0)", "\($0.1)") })
        XCTAssertEqual(Dictionary(stringElements), strings)
    }
    
    func testAdd() {
    
        let result = nums + cubes
        
        XCTAssertEqual(result, [1: 1, 2: 8, 3: 27, 4: 64, 5: 125, 10:10])

    }
}
