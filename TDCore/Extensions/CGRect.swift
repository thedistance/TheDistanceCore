//
//  CGRect.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

extension CGRect {
    
    /// Creates a new `CGRect` based on `self` with the given `insets`. This allows non-symmetric insets, where `CGRectInset` does not.
    func rectWithInsets(insets:UIEdgeInsets) -> CGRect {
        
        var newRect = self
        newRect.origin.x += insets.left
        newRect.origin.y += insets.top
        newRect.size.width -= insets.totalXInset
        newRect.size.height -= insets.totalYInset
        
        return newRect
    }
}