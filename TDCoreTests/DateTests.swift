//
//  DateTests.swift
//  TDCore
//
//  Created by Josh Campion on 02/11/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest
import TheDistanceCore

class DateTests: XCTestCase {

    var now = Date()
    var now2:Date!
    var then:Date!
    var soon:Date!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        now2 = now.addingTimeInterval(0)
        then = now.addingTimeInterval(-60)
        soon = now.addingTimeInterval(60)
    }

    func testComponets() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Europe/London")!

        let comps = Calendar.current.dateComponents(in: TimeZone(identifier: "Europe/London")!, from: now)
        
        let dateUnits = Set<Calendar.Component>([.year, .month, .day])
        let timeUnits = Set<Calendar.Component>([.hour, .minute, .second])
        let specialUnits = Set<Calendar.Component>([.timeZone, .calendar])

        let dateComps = calendar.dateComponents(dateUnits, from: now)
        let timeComps = calendar.dateComponents(timeUnits, from: now)
        let specialComps = calendar.dateComponents(specialUnits, from: now)
        
        var dateElements = Set<Calendar.Component>([.year, .month, .day])
        for unit in dateUnits {
            // test date has been copied and time hasn't
            XCTAssertEqual(comps.value(for: unit), dateComps.value(for: unit))
            XCTAssertEqual(NSNotFound, timeComps.value(for: unit))
            XCTAssertEqual(NSNotFound, specialComps.value(for: unit))
            
            if let index = dateElements.index(of: unit) {
                dateElements.remove(at: index)
            } else {
                XCTFail("Unable to find calendar unit \(unit) in \(dateElements)")
            }
        }
        XCTAssertEqual(0, dateElements.count, "Date elements not correctly enumerated")
        
        var timeElements = Set<Calendar.Component>([.hour, .minute, .second])
        for unit in timeUnits {
            // test time has been copied and date hasn't
            XCTAssertEqual(comps.value(for: unit), timeComps.value(for: unit))
            XCTAssertEqual(NSNotFound, dateComps.value(for: unit))
            XCTAssertEqual(NSNotFound, specialComps.value(for: unit))
            
            if let index = timeElements.index(of: unit) {
                timeElements.remove(at: index)
            } else {
                XCTFail("Unable to find calendar unit \(unit) in \(timeElements)")
            }
        }
        XCTAssertEqual(0, timeElements.count, "Time elements not correctly enumerated")
        
        XCTAssertEqual((comps as NSDateComponents).timeZone, (specialComps as NSDateComponents).timeZone)
        XCTAssertNil((dateComps as NSDateComponents).timeZone)
        XCTAssertNil((timeComps as NSDateComponents).timeZone)
        
        XCTAssertEqual((comps as NSDateComponents).calendar, (specialComps as NSDateComponents).calendar)
        XCTAssertNil((dateComps as NSDateComponents).calendar)
        XCTAssertNil((timeComps as NSDateComponents).calendar)
    }

    func testDateGreatherThan() {
        
        
        // test >
        XCTAssert(soon.timeIntervalSinceReferenceDate > now.timeIntervalSinceReferenceDate)
        XCTAssert(soon.timeIntervalSinceReferenceDate > then.timeIntervalSinceReferenceDate)
        XCTAssert(now.timeIntervalSinceReferenceDate > then.timeIntervalSinceReferenceDate)
        
        XCTAssertFalse(then.timeIntervalSinceReferenceDate > now.timeIntervalSinceReferenceDate)
        XCTAssertFalse(then.timeIntervalSinceReferenceDate > soon.timeIntervalSinceReferenceDate)
        XCTAssertFalse(now.timeIntervalSinceReferenceDate > soon.timeIntervalSinceReferenceDate)
    }
    
    func testDateLessThan() {
        // test <
        XCTAssert(then.timeIntervalSinceReferenceDate < now.timeIntervalSinceReferenceDate)
        XCTAssert(then.timeIntervalSinceReferenceDate < soon.timeIntervalSinceReferenceDate)
        XCTAssert(now.timeIntervalSinceReferenceDate < soon.timeIntervalSinceReferenceDate)
        
        XCTAssertFalse(soon.timeIntervalSinceReferenceDate < now.timeIntervalSinceReferenceDate)
        XCTAssertFalse(soon.timeIntervalSinceReferenceDate < then.timeIntervalSinceReferenceDate)
        XCTAssertFalse(now.timeIntervalSinceReferenceDate < then.timeIntervalSinceReferenceDate)
    }
    
    func testDateGreatherThanOrEqual() {
        // test >=
        XCTAssert(soon >= now)
        XCTAssert(soon >= then)
        XCTAssert(now >= then)
        
        XCTAssertFalse(then >= now)
        XCTAssertFalse(then >= soon)
        XCTAssertFalse(now >= soon)
        
        XCTAssert(now >= now2)
    }
    
    func testDateLessThanOrEqual() {
        // test <=
        XCTAssert(then <= now)
        XCTAssert(then <= soon)
        XCTAssert(now <= soon)
        
        XCTAssertFalse(soon <= now)
        XCTAssertFalse(soon <= then)
        XCTAssertFalse(now <= then)

        XCTAssert(now <= now2)
    }
    
    func testDateEqual() {
        // test ==
        XCTAssert(now == now2)
        XCTAssertFalse(now != now2)
    }
}
