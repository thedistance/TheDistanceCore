//
//  OptionSet.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation


public extension OptionSetType where Element == Self, RawValue : UnsignedIntegerType {
    
    /**
     
     Convenience method for iterating over an option set.
     
     The calculation is performed by overflow multiplication `&* 2` of `Self.RawValue(1)` as left shift (`<<`) is only defined for concrete integer types, not the `UnsignedIntegerType` this protocol is defined on.
     
     - note: This method was originally detailed on [StackOverflow](http://stackoverflow.com/a/32107400/4074727)
     
     - returns: Any array of options.
     */
    public func elements() -> AnySequence<Self> {
        var rawValue = Self.RawValue(1)
        return AnySequence( {
            return AnyGenerator(body: {
                while rawValue != 0 {
                    let candidate = Self(rawValue: rawValue)
                    rawValue = rawValue &* 2
                    if self.contains(candidate) {
                        return candidate
                    }
                }
                
                return nil
            })
        })
    }
}