//
//  TargetObject.swift
//  Pods
//
//  Created by Josh Campion on 09/02/2016.
//
//

import UIKit

/// A class for handling `UIControl.addTarget(_:action:forControlEvents:)` in a pure swift class.
open class ObjectTarget<T:UIControl>:NSObject {
    
    /// The control which will trigger the completion on the given control events.
    open let control:UIControl
    
    /// The completion box that will run for the given control events.
    open let completion:(_ sender:T) -> ()
    
    /**
     
     Default initialiser.
     
     - parameter control: The `UIControl` on which events will trigger the `completion` block.
     - parameter forControlEvents: The `UIControlEvents` sent by `control` that will trigger `completion`.
     - parameter completion: The code that will run when `control` sends `forControlEvents`.
     
    */
    public init(control:T, forControlEvents:UIControl.Event, completion:@escaping (_ sender:T) -> ()) {
        self.control = control
        self.completion = completion
        
        super.init()
        
        control.addTarget(self, action: #selector(ObjectTarget.targetted(_:)), for: forControlEvents)
    }
    
    /// The function that is called from `UIControl.addTarget(_:action:forControlEvents:)`.
    @objc open func targetted(_ sender:AnyObject?) {
        
        if let typedSender = sender as? T {
            completion(typedSender)
        }
    }
}
