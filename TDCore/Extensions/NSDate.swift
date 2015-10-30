//
//  NSDate.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

/**
 
 Convenience function for comparing two `NSDate` objects.
 
 - note: `compareDate(_:toDate:toUnitGranularity:)` should be used for more complex comparing.

 - returns: `true` if `d1.compare(d2)` returns `.OrderedDescending`.
*/
public func >(d1:NSDate, d2:NSDate) -> Bool {
    return d1.compare(d2) == .OrderedDescending
}

/**
 
 Convenience function for comparing two `NSDate` objects.
 
 - note: `compareDate(_:toDate:toUnitGranularity:)` should be used for more complex comparing.
 
 - returns: `true` if `d1.compare(d2)` returns `.OrderedAscending`.
 */
public func <(d1:NSDate, d2:NSDate) -> Bool {
    return d1.compare(d2) == .OrderedAscending
}

/**
 
 Convenience function for comparing two `NSDate` objects.
 
 - note: `compareDate(_:toDate:toUnitGranularity:)` should be used for more complex comparing.
 
 - returns: `true` if `d1.compare(d2)` is not `.OrderedAscending`.
 */

public func >=(d1:NSDate, d2:NSDate) -> Bool {
    return d1.compare(d2) != .OrderedAscending
}

/**
 
 Convenience function for comparing two `NSDate` objects.
 
 - note: `compareDate(_:toDate:toUnitGranularity:)` should be used for more complex comparing.
 
 - returns: `true` if `d1.compare(d2)` is not `.OrderedDescending`.
 */

public func <=(d1:NSDate, d2:NSDate) -> Bool {
    return d1.compare(d2) != .OrderedDescending
}