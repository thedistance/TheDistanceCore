//
//  Observer.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

/**
 
 Definition of an object for adding KVO and `NSNotificationCenter` obeservations to pure Swift classes.
 
 `NSObject`s implement a method called `methodSignatureForSelector:` which converts from strings to methods. Pure Swift classes do not have this method so cannot inherently perform KVO or observe `NSNotificationCenter` posts. Rather than making a Swift class inherit from `NSObject`, which introuduces unnecessary features, an `Observer` can be retained which performs an arbitrary block on copmletion.
 
 Two default implementations are provided, `NotificationObserver` and `ObjectObserver` for `NSNotificationCenter` observing and keypath observing respectively.
 
 */
public protocol Observer {
    
    /// Should be called by the user of the `Observer` to register as an observer
    func beginObserving()
    
    /// Should be called by the user of the `Observer` to unregister as an observer.
    func endObserving()
    
}