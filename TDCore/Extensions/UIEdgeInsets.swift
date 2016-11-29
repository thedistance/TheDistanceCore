//
//  UIEdgeInsets.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import UIKit

/**
 
 Convenience creator for even `UIEdgeInsets`.
 
 - parameter inset: The amount for each side of the inset.
 - returns: A `UIEdgeInsets` with `top`, `left`, `bottom` and `right` all set to `inset`.
*/
public func UIEdgeInsetsMakeEqual(_ inset:CGFloat) -> UIEdgeInsets {
    
    return UIEdgeInsetsMake(inset, inset, inset, inset)
}

public extension UIEdgeInsets {
    
    /// Returns `top + bottom` for use in calculating size with an inset.
    public var totalYInset:CGFloat {
        return top + bottom
    }
    
    /// Returns `left + right` for use in calculating size with an inset.
    public var totalXInset:CGFloat {
        return left + right
    }
}
