//
//  String.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

public extension String {
    
    /// Convenience method to trim whitespace and newline characters from `self`.
    public mutating func trimWhitespace() {
        self = self.whitespaceTrimmedString()
    }
    
    /// Convenience method to create a new string from `self`, trimmed from whitespace and newline characters.
    public func whitespaceTrimmedString() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}