//
//  CGRect.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

public extension CGRect {
    
    /**

    Creates a new `CGRect` based on `self` with the given `insets`. This allows non-symmetric insets, where `CGRectInset` does not.

     - parameter insets: The insets to create the new CGRect from.
     - parameter capsToZero: Whether or not the width and height of the new rect should be non-negative. The default value is `true`.

     */
    public func rectWithInsets(insets:UIEdgeInsets, capsToZero:Bool = true) -> CGRect {
        
        var newRect = self
        newRect.origin.x += insets.left
        newRect.origin.y += insets.top
        newRect.size.width -= insets.totalXInset
        newRect.size.height -= insets.totalYInset
        
        if capsToZero {
            newRect.size.width = max(0, newRect.size.width)
            newRect.size.height = max(0, newRect.size.height)
        }
        
        return newRect
    }
    
    /// The center of this rect as defined by `CGRectGetMidX(_:)` and `CGRectGetMidY(_:)`
    public var center:CGPoint {
        return CGPointMake(CGRectGetMidX(self), CGRectGetMidY(self))
    }
}