//
//  String.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

extension String {
    
    /// Convenience method to trim whitespace and newline characters from `self`.
    mutating func removeWhiteSpace() {
        self = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    /// Convenience method to create a new string from `self`, trimmed from whitespace and newline characters.
    func whiteSpaceRemovedString() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}