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
     
     - parameter components: The components to copy to the new object.
     - parameter fromComponents: The object to copy the `units` from.
     
    */
    public convenience init(units: NSCalendarUnit, fromComponents:NSDateComponents) {
        
        self.init()
        
        for comp in units.elements() {
            
            if comp == .TimeZone {
                timeZone = fromComponents.timeZone
            } else if comp == .Calendar {
                calendar = fromComponents.calendar
            } else {
                setValue(fromComponents.valueForComponent(comp), forComponent: comp)
            }
            
            /*
            // doesn't compile...
            switch comp {
            case .TimeZone:
                timeZone = fromComponents.timeZone
                case .Calendar:
                calendar = fromComponents.calendar
            default:
                setValue(fromComponents.valueForComponent(comp), forComponent: comp)
            }
            */
        }
    }
    
}