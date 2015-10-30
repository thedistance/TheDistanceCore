//
//  ObserverTests.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest
import TDCore

class ObserverTests: XCTestCase {

    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNotificationObserver() {
        
        var observed = [String]()
        
        let poster = NSObject()
        
        let notePoster = NSNotification(name: "Test", object: poster)
        let note = NSNotification(name: "Test", object: nil)
        
        let posterObserver = NotificationObserver(name: "Test", object: poster) { (note) -> () in
            observed.append("poster " + note.name)
        }
        
        let observer = NotificationObserver(name: "Test", object: nil) { (note) -> () in
            observed.append(note.name)
        }
        
        NSNotificationCenter.defaultCenter().postNotification(note)
        NSNotificationCenter.defaultCenter().postNotification(notePoster)
        
        let expected = ["Test", "poster Test", "Test"]
        
        print(observed)
        
        XCTAssertEqual(expected, observed)
        
        posterObserver.endObserving()
        observer.endObserving()
        
        NSNotificationCenter.defaultCenter().postNotification(note)
        NSNotificationCenter.defaultCenter().postNotification(notePoster)
        
        posterObserver.beginObserving()
        observer.beginObserving()
        
        NSNotificationCenter.defaultCenter().postNotification(note)
        NSNotificationCenter.defaultCenter().postNotification(notePoster)
        
        let expected2 = ["Test", "poster Test", "Test", "Test", "poster Test", "Test"]
        
        print(observed)
        
        XCTAssertEqual(expected2, observed)
    }

    func testObjectObserver() {
        
        var observed = [String]()

        let startFrame = CGRectMake(0, 0, 25, 50)
        let endFrame = CGRectMake(25, 50, 75, 100)
        
        let modifier = UIView(frame: startFrame)
        
        let observer = ObjectObserver(keypath: "frame", object: modifier) { (keypath, object, change) -> () in
            
            guard let f1 = (change?[NSKeyValueChangeOldKey] as? NSValue)?.CGRectValue(),
                let f2 = (change?[NSKeyValueChangeNewKey] as? NSValue)?.CGRectValue() else { return }
            
            observed.append("\(keypath): \(f1) -> \(f2)")
        }
        
        let expectedStart = "frame: \(startFrame) -> \(endFrame)"
        let expectedEnd = "frame: \(endFrame) -> \(startFrame)"
        
        modifier.frame = endFrame
        
        XCTAssertEqual([expectedStart], observed)
        
        observer.endObserving()
        
        modifier.frame = startFrame
        
        observer.beginObserving()
        
        modifier.frame = endFrame
        
        modifier.frame = startFrame
        
        XCTAssertEqual([expectedStart, expectedStart, expectedEnd], observed)
    }
}
