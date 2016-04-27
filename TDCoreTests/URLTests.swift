//
//  URLTests.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest
import TheDistanceCore

class URLTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testChromeURL() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let url = NSURL(string: "http://stackoverflow.com/questions/32102936/how-do-you-enumerate-optionsettype-in-swift-2?answertab=active#tab-top")!
        let surl = NSURL(string: "https://stackoverflow.com/questions/32102936/how-do-you-enumerate-optionsettype-in-swift-2?answertab=active#tab-top")!
        
        let chromeURL = NSURL(string: "googlechrome://stackoverflow.com/questions/32102936/how-do-you-enumerate-optionsettype-in-swift-2?answertab=active#tab-top")!
        let chromeSURL = NSURL(string: "googlechromes://stackoverflow.com/questions/32102936/how-do-you-enumerate-optionsettype-in-swift-2?answertab=active#tab-top")!
    
        XCTAssertEqual(url.googleChromeURL()!, chromeURL)
        XCTAssertEqual(surl.googleChromeURL()!, chromeSURL)
    }

}
