//
//  TargetObject.swift
//  Pods
//
//  Created by Josh Campion on 09/02/2016.
//
//

import UIKit

/// A class for handling `UIControl.addTarget(_:action:forControlEvents:)` in a pure swift class.
public class ObjectTarget<T:UIControl>:NSObject {
    
    /// The control which will trigger the completion on the given control events.
    public let control:UIControl
    
    /// The completion box that will run for the given control events.
    public let completion:(sender:T) -> ()
    
    /**
     
     Default initialiser.
     
     - parameter control: The `UIControl` on which events will trigger the `completion` block.
     - parameter forControlEvents: The `UIControlEvents` sent by `control` that will trigger `completion`.
     - parameter completion: The code that will run when `control` sends `forControlEvents`.
     
    */
    public init(control:T, forControlEvents:UIControlEvents, completion:(sender:T) -> ()) {
        self.control = control
        self.completion = completion
        
        super.init()
        
        control.addTarget(self, action: #selector(ObjectTarget.targetted(_:)), forControlEvents: forControlEvents)
    }
    
    /// The function that is called from `UIControl.addTarget(_:action:forControlEvents:)`.
    public func targetted(sender:AnyObject?) {
        
        if let typedSender = sender as? T {
            completion(sender: typedSender)
        }
    }
}