//
//  Dictionary.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

/**
 
 Convenience function to create a new dictionary with the results of `assignNewValuesFrom(_:)` for two dictionaries of the same type.
 
 - parameter d1: A dictionary which forms the basis for assignment.
 - parameter d2: A dictionary which provides the new values for assignment.
 
 - returns: A new dictionary based with the entries from `d2` being set on `d1`.
 
 */

public func +<Key,Value>(d1:Dictionary<Key,Value>, d2:Dictionary<Key,Value>) -> Dictionary<Key,Value> {

    var new = d1
    for (k,v) in d2 {
        new[k] = v
    }
    
    return new
}

public extension Dictionary {
    
    /// Convenience creator to create a dictionary from an array of key-value tuples. This is useful for creating a dictionary from the result of performing `map(_:)` on a dictionary.
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (Key,Value)  {
        self = [:]
        for (k,v) in sequence {
            self[k] = v
        }
    }
    
    /// Creates a new dictionary by transforming only the values in `self`

    public mutating func mapValues(transform: (_ key:Key, _ value:Value) -> (Value)) {
        for key in self.keys {
            let newValue = transform(key, self[key]!)
            self.updateValue(newValue, forKey: key)
        }
    }
    
    
    /// - returns: An array of only the values in `self`.
    public func valuesArray() -> [Value] {
        return self.map({ $0.1 })
    }
}
