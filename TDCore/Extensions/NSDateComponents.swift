//
//  NSDateComponents.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

public extension DateComponents {
    
    /**

     Convenience initialiser for creating a new `NSDateComponets` object as they inherit from `NSObject` and therefore have reference and not value semantics.
     
     - parameter components: The components to copy to the new object.
     - parameter fromComponents: The object to copy the `units` from.
     

    public init(units: Calendar.Unit, fromComponents: DateComponents) {
        
        self.init()
        
        for comp in units.elements() {
            switch comp {
            case .timeZone:
                timeZone = fromComponents.timeZone
            case .calendar:
                calendar = fromComponents.calendar
            default:
                setValue(fromComponents.valueForComponent(comp), forComponent: comp)
            }
        }
    }
    */
    
}
