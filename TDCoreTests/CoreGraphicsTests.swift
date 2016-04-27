//
//  CoreGraphicsTests.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest

import TheDistanceCore

class CoreGraphicsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRectInset() {
        
        let rect = CGRectMake(50, 75, 50, 100)
        
        let rect1 = CGRectMake(57, 87, 2, 65)
        
        let rect2 = CGRectMake(43, 63, 98, 0)
        let rect2N = CGRectMake(43, 63, 98, -11)

        let rect3 = CGRectMake(43, 63, 0, 0)
        let rect3N = CGRectMake(43, 63, -3, -11)
        
        // test basic inset
        let inset1 = UIEdgeInsetsMake(12, 7, 23, 41)
        XCTAssertEqual(rect1, rect.rectWithInsets(inset1))
        
        // test zero height and negative height
        let inset2 = UIEdgeInsetsMake(-12, -7, 123, -41)
        XCTAssertEqual(rect2, rect.rectWithInsets(inset2))
        XCTAssertEqual(rect2N, rect.rectWithInsets(inset2, capsToZero: false))
        
        // test zero with and negative width
        let inset3 = UIEdgeInsetsMake(-12, -7, 123, 60)
        XCTAssertEqual(rect3, rect.rectWithInsets(inset3))
        XCTAssertEqual(rect3N, rect.rectWithInsets(inset3, capsToZero: false))
    }

    func testUIEdgeInsetsInsets() {
        
        let baseInsets = UIEdgeInsetsMake(5, 10, 15, 20)
        
        XCTAssertEqual(baseInsets.totalXInset, 30)
        XCTAssertEqual(baseInsets.totalYInset, 20)
    }
    
    func testUIEdgeInsetsEqual() {
        XCTAssertEqual(UIEdgeInsetsMakeEqual(15), UIEdgeInsetsMake(15, 15, 15, 15))
    }
}
