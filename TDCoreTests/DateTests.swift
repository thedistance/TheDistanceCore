//
//  DateTests.swift
//  TDCore
//
//  Created by Josh Campion on 02/11/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest
import TDCore

class DateTests: XCTestCase {

    var now = NSDate()
    var now2:NSDate!
    var then:NSDate!
    var soon:NSDate!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        now2 = now.dateByAddingTimeInterval(0)
        then = now.dateByAddingTimeInterval(-60)
        soon = now.dateByAddingTimeInterval(60)
    }

    func testComponets() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let comps = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone(name: "Europe/London")!, fromDate: now)
        
        let dateUnits:NSCalendarUnit = [.Year, .Month, .Day]
        let timeUnits:NSCalendarUnit = [.Hour, .Minute, .Second]
        let specialUnits:NSCalendarUnit = [.TimeZone, .Calendar]
        
        let dateComps = NSDateComponents(units: dateUnits, fromComponents: comps)
        let timeComps = NSDateComponents(units: timeUnits, fromComponents: comps)
        let specialComps = NSDateComponents(units: specialUnits, fromComponents: comps)
        
        for unit in dateUnits.elements() {
            // test date has been copied and time hasn't
            XCTAssertEqual(comps.valueForComponent(unit), dateComps.valueForComponent(unit))
            XCTAssertEqual(NSNotFound, timeComps.valueForComponent(unit))
            XCTAssertEqual(NSNotFound, specialComps.valueForComponent(unit))
        }
        
        for unit in timeUnits.elements() {
            // test time has been copied and date hasn't
            XCTAssertEqual(comps.valueForComponent(unit), timeComps.valueForComponent(unit))
            XCTAssertEqual(NSNotFound, dateComps.valueForComponent(unit))
            XCTAssertEqual(NSNotFound, specialComps.valueForComponent(unit))
        }
        
        XCTAssertEqual(comps.timeZone, specialComps.timeZone)
        XCTAssertNil(dateComps.timeZone)
        XCTAssertNil(timeComps.timeZone)
        
        XCTAssertEqual(comps.calendar, specialComps.calendar)
        XCTAssertNil(dateComps.calendar)
        XCTAssertNil(timeComps.calendar)
    }

    func testDateGreatherThan() {
        
        
        // test >
        XCTAssert(soon > now)
        XCTAssert(soon > then)
        XCTAssert(now > then)
        
        XCTAssertFalse(then > now)
        XCTAssertFalse(then > soon)
        XCTAssertFalse(now > soon)
    }
    
    func testDateLessThan() {
        // test <
        XCTAssert(then < now)
        XCTAssert(then < soon)
        XCTAssert(now < soon)
        
        XCTAssertFalse(soon < now)
        XCTAssertFalse(soon < then)
        XCTAssertFalse(now < then)
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
