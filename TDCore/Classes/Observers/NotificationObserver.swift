//
//  NotificationObserver.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

/**
 
 Implementation of `Observer` for observing an `NSNotificationCenter`. Observation begins on `init` and ends on `deinit()` unless called otherwise.
 
 For efficiency the class is marked as final. If necessary, convenience initialisers can be created using extensions.
 
 */
public final class NotificationObserver:NSObject, Observer {
    
    /// The name being observed on the `center`.
    public let name:String
    
    /// The `NSNotificationCenter` to listen for notifications on.
    public let center:NSNotificationCenter
    
    /// The block to run when the notification is oberserved.
    private let completion:(note:NSNotification) -> ()
    
    /// The object to restrict observed notifications to.
    public let object:AnyObject?
    
    /// Flag for whether this `Observer` is currently registered as an observer on `center`.
    public private(set) var observing:Bool = false
    
    /**
     
     Default initialiser.
     
     - parameter name: The notification name to listen for.
     - parameter object: The object to restrict observed notifications from.
     - parameter center: The `NSNotificationCenter` to observe. The default value is `NSNotificationCenter.defaultCenter()`.
     - parameter completion: The block to perform when `name` by `object` is observed on `center`.
     */
    public init(name:String, object:AnyObject?, center:NSNotificationCenter = NSNotificationCenter.defaultCenter(), completion:(note:NSNotification) -> ()) {
        
        self.name = name
        self.completion = completion
        self.object = object
        self.center = center
        
        super.init()
        
        beginObserving()
    }
    
    /// Called when the registered notification is observed.
    private func observe(note:NSNotification) {
        completion(note: note)
    }
    
    /// Registers `self` to observe `center` for `name` restricted to `object`.
    public func beginObserving() {
        if !observing {
            center.addObserver(self, selector: "observe:", name: name, object: object)
            observing = true
        }
    }
    
    /// Unregisters `self` to stop observing `center` for `name` restricted to `object`.
    public func endObserving() {
        if observing {
            center.removeObserver(self, name: name, object: object)
            observing = false
        }
    }
    
    deinit {
        endObserving()
    }
}
