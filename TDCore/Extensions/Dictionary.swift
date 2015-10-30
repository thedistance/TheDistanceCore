//
//  Dictionary.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation


extension Dictionary {
    
    /// Convenience method to assign all values in `source` to self.
    mutating func assignValuesFrom<S: SequenceType where S.Generator.Element == (Key,Value)>(source: S) {
        for (k,v) in source {
            self[k] = v
        }
    }
    
    /// Convenience creator to create a dictionary from an array of key-value tuples. This is useful for creating a dictionary from the result of performing `map(_:)` on a dictionary.
    init<S: SequenceType where S.Generator.Element == (Key,Value)>(_ sequence: S) {
        self = [:]
        self.assignValuesFrom(sequence)
    }
    
    /**
     
     Creates a new dictionary by transforming only the values in `self`.
     
     - parameter: The closure to be applied to the values, as would be passed to `map(_:)` on an array.
     
     */
    func mapValues<NewValue>(transform: Value -> NewValue) -> [Key:NewValue] {
        
        let elements = self.map({ ($0, transform($1)) })
        
        return Dictionary<Key, NewValue>(elements)
    }
    
    /// - returns: An array of only the values in `self`.
    func valuesArray() -> [Value] {
        return self.map({ $0.1 })
    }
}
