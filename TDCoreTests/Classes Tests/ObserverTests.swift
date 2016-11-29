//
//  ObserverTests.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import XCTest
import TheDistanceCore

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
        
        let notePoster = Notification(name: Notification.Name(rawValue: "Test"), object: poster)
        let note = Notification(name: Notification.Name(rawValue: "Test"), object: nil)
        
        let posterObserver = NotificationObserver(name: "Test", object: poster) { (note) -> () in
            observed.append("poster " + note.name)
        }
        
        let observer = NotificationObserver(name: "Test", object: nil) { (note) -> () in
            observed.append(note.name)
        }
        
        NotificationCenter.default.post(note)
        NotificationCenter.default.post(notePoster)
        
        let expected = ["Test", "poster Test", "Test"]
        
        print(observed)
        
        XCTAssertEqual(expected, observed)
        
        posterObserver.endObserving()
        observer.endObserving()
        
        NotificationCenter.default.post(note)
        NotificationCenter.default.post(notePoster)
        
        posterObserver.beginObserving()
        observer.beginObserving()
        
        NotificationCenter.default.post(note)
        NotificationCenter.default.post(notePoster)
        
        let expected2 = ["Test", "poster Test", "Test", "Test", "poster Test", "Test"]
        
        print(observed)
        
        XCTAssertEqual(expected2, observed)
    }

    func testObjectObserver() {
        
        var observed = [String]()

        let startFrame = CGRect(x: 0, y: 0, width: 25, height: 50)
        let endFrame = CGRect(x: 25, y: 50, width: 75, height: 100)
        
        let modifier = UIView(frame: startFrame)
        
        let observer = ObjectObserver(keypath: "frame", object: modifier) { (keypath, object, change) -> () in
            
            guard let f1 = (change?[NSKeyValueChangeKey.oldKey] as? NSValue)?.CGRectValue,
                let f2 = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.CGRectValue else { return }
            
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
