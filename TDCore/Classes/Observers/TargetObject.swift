//
//  TargetObject.swift
//  Pods
//
//  Created by Josh Campion on 09/02/2016.
//
//

import UIKit

public class ObjectTarget<T:UIControl>:NSObject {
    
    public let control:UIControl
    public let completion:(sender:T) -> ()
    
    public init(control:T, forControlEvents:UIControlEvents, completion:(sender:T) -> ()) {
        self.control = control
        self.completion = completion
        
        super.init()
        
        control.addTarget(self, action: "targetted:", forControlEvents: forControlEvents)
    }
    
    public func targetted(sender:AnyObject?) {
        
        if let typedSender = sender as? T {
            completion(sender: typedSender)
        }
    }
}