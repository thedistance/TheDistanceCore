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

        let comps = Calendar.current.dateComponents(in: TimeZone(identifier: "Europe/London")!, from: now)
        
        let dateUnits:NSCalendar.Unit = [.year, .month, .day]
        let timeUnits:NSCalendar.Unit = [.hour, .minute, .second]
        let specialUnits:NSCalendar.Unit = [.timeZone, .calendar]
        
        let dateComps = DateComponents(calendar: dateUnits, timeZone: comps)
        let timeComps = DateComponents(calendar: timeUnits, timeZone: comps)
        let specialComps = DateComponents(calendar: specialUnits, timeZone: comps)
        
        var dateElements:[NSCalendar.Unit] = [.year, .month, .day]
        for unit in dateUnits.elements() {
            // test date has been copied and time hasn't
            XCTAssertEqual(comps.value(forComponent: unit), dateComps.value(forComponent: unit))
            XCTAssertEqual(NSNotFound, timeComps.value(forComponent: unit))
            XCTAssertEqual(NSNotFound, specialComps.value(forComponent: unit))
            
            if let index = dateElements.index(of: unit) {
                dateElements.remove(at: index)
            } else {
                XCTFail("Unable to find calendar unit \(unit) in \(dateElements)")
            }
        }
        XCTAssertEqual(0, dateElements.count, "Date elements not correctly enumerated")
        
        var timeElements:[NSCalendar.Unit] = [.hour, .minute, .second]
        for unit in timeUnits.elements() {
            // test time has been copied and date hasn't
            XCTAssertEqual(comps.value(forComponent: unit), timeComps.value(forComponent: unit))
            XCTAssertEqual(NSNotFound, dateComps.value(forComponent: unit))
            XCTAssertEqual(NSNotFound, specialComps.value(forComponent: unit))
            
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
