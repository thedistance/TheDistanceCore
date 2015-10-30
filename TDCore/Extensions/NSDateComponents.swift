//
//  NSDateComponents.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

public extension NSDateComponents {
    
    /**

     Convenience initialiser for creating a new `NSDateComponets` object as they inherit from `NSObject` and therefore have reference and not value semantics.
     
     - warning: This uses `setValue(_:forComponent)` to assign the values to the created `NSDateComponents` object. Consequently `.timeZone` and `.calendar` are not copied to the new object.
     
     - parameter components: The components to copy to the new object.
     - parameter fromComponents: The object to copy the `units` from.
     
    */
    convenience init(units: NSCalendarUnit, fromComponents:NSDateComponents) {
        
        self.init()
        
        for comp in units.elements() where (comp != .Calendar && comp != .TimeZone) {
            setValue(fromComponents.valueForComponent(comp), forComponent: comp)
        }
    }
    
}