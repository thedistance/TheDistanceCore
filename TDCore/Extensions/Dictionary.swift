//
//  Dictionary.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

public func +<K,V>(d1:Dictionary<K,V>, d2:Dictionary<K,V>) -> Dictionary<K,V> {

    var new = d1
    new.assignValuesFrom(d2)
    
    return new
}

public extension Dictionary {
    
    /// Convenience method to assign all values in `source` to self.
    public mutating func assignValuesFrom<S: SequenceType where S.Generator.Element == (Key,Value)>(source: S) {
        for (k,v) in source {
            self[k] = v
        }
    }
    
    /// Convenience creator to create a dictionary from an array of key-value tuples. This is useful for creating a dictionary from the result of performing `map(_:)` on a dictionary.
    public init<S: SequenceType where S.Generator.Element == (Key,Value)>(_ sequence: S) {
        self = [:]
        self.assignValuesFrom(sequence)
    }
    
    /**
     
     Creates a new dictionary by transforming only the values in `self`.
     
     - parameter: The closure to be applied to the values, as would be passed to `map(_:)` on an array.
     
     */
    public func mapValues<NewValue>(transform: Value -> NewValue) -> [Key:NewValue] {
        
        let elements = self.map({ ($0, transform($1)) })
        
        return Dictionary<Key, NewValue>(elements)
    }
    
    /// - returns: An array of only the values in `self`.
    public func valuesArray() -> [Value] {
        return self.map({ $0.1 })
    }
}
