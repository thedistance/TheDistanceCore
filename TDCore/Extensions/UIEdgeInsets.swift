//
//  UIEdgeInsets.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

extension UIEdgeInsets {
    
    /// Returns `top + bottom` for use in calculating size with an inset.
    var totalYInset:CGFloat {
        return top + bottom
    }
    
    /// Returns `left + right` for use in calculating size with an inset.
    var totalXInset:CGFloat {
        return left + right
    }
}