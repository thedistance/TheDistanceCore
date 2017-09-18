//
//  OptionSet.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation


public extension OptionSet where RawValue : FixedWidthInteger {
    
    /**
     
     Convenience method for iterating over an option set.
     
     The calculation is performed by overflow multiplication `&* 2` of `Self.RawValue(1)` as left shift (`<<`) is only defined for concrete integer types, not the `UnsignedIntegerType` this protocol is defined on.
     
     - note: This method was originally detailed on [StackOverflow](http://stackoverflow.com/a/32107400/4074727)
     
     - returns: Any array of options.
     */
    func elements() -> AnySequence<Self> {
        var remainingBits = rawValue
        var bitMask: RawValue = 1
        return AnySequence {
            return AnyIterator {
                while remainingBits != 0 {
                    defer { bitMask = bitMask &* 2 }
                    if remainingBits & bitMask != 0 {
                        remainingBits = remainingBits & ~bitMask
                        return Self(rawValue: bitMask)
                    }
                }
                return nil
            }
        }
    }
}
