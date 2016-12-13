//
//  ObjectObserver.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

/**
 
 Implementation of `Observer` for observing a keypath setter of an object. Observation begins on `init` and ends on `deinit` unless called otherwise.
 
 For efficiency the class is marked as final. If necessary, convenience initialisers can be created using extensions.
 
 */
public final class ObjectObserver:NSObject, Observer {
    
    /// The keypath being observed on `object`.
    public let keypath:String
    
    /// The block to run when the oberservation occurs.
    fileprivate let completion:(_ keypath:String, _ object:NSObject, _ change:[NSKeyValueChangeKey : Any]?) -> ()
    
    /// The object to to observe `keypath` on.
    public let object:NSObject
    
    /// The options applied to the observation.
    public let options:NSKeyValueObservingOptions
    
    /// The context to observe in.
    public let context:UnsafeMutableRawPointer
    
    /// Flag for whether this `Observer` is currently registered as an observer on `center`.
    public fileprivate(set) var observing:Bool = false
    
    /**
     
     Default initialiser.
     
     - parameter keypath: The keypath to observe.
     - parameter object: The object to observe `keypath` on.
     - parameter options: The KVO options. The default value is `.Old` and `.New`.
     - parameter context: The KVO context to observe in. The default value is nil.
     - parameter completion: The block to perform when `keypath` is set on `object`.
     
     */
    public init(keypath:String, object:NSObject, options: NSKeyValueObservingOptions = [.old, .new], context:UnsafeMutableRawPointer? = nil, completion:@escaping (_ keypath:String, _ object:NSObject, _ change:[NSKeyValueChangeKey : Any]?) -> ()) {
        
        
        self.keypath = keypath
        self.object = object
        self.completion = completion
        self.options = options
        self.context = context ?? UnsafeMutableRawPointer(bitPattern: 1)!
        
        super.init()
        
        beginObserving()
    }
    
//    
//    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        
//        if let key = keyPath,
//            let obj = object as? NSObject
//            where obj == self.object && key == self.keypath {
//            completion(keypath: self.keypath, object: self.object, change: change)
//        }
//    }
    
    /// Overrides default to call `completion` if `object` and `keypath` match the parameters.
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let key = keyPath,
        let obj = object as? NSObject, obj == self.object && key == self.keypath {
            completion(self.keypath, self.object, change)
        }
    }
    
    /// Registers `self` to observe `center` for `name` restricted to `object`.
    public func beginObserving() {
        if !observing {
            object.addObserver(self, forKeyPath: keypath, options: options, context: context)
            observing = true
        }
    }
    
    /// Unregisters `self` to stop observing `center` for `name` restricted to `object`.
    public func endObserving() {
        if observing {
            object.removeObserver(self, forKeyPath: keypath, context: context)
            observing = false
        }
    }
    
    deinit {
        endObserving()
    }
}
