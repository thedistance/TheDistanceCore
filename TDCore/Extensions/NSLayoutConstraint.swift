//
//  NSLayoutConstraint.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

extension NSLayoutConstraint {
    
    /**
     
     Convenience method to programmatically create `NSLayoutConstraint`s to size a given `UIView` to a fixed height, width or both.

     - parameter view: The `UIView` the returned constraints are configure to.
     - parameter toWidth: If not `nil`, an `NSLayoutConstraint` configured to size the `view` to this width is created.
     - parameter andHeight: If not `nil`, an `NSLayoutConstraint` configured to size the `view` to this height is created.
     
     - returns: An array of `NSLayoutConstraint`s ordered width, height.
     
    */
    static func constraintsToSize(view:UIView, toWidth width:CGFloat?, andHeight height:CGFloat?) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        if let w = width {
            let constr = NSLayoutConstraint(item: view,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 0.0,
                constant: w)
            constraints.append(constr)
        }
        
        if let h = height {
            let constr = NSLayoutConstraint(item: view,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 0.0,
                constant: h)
            constraints.append(constr)
        }
        
        return constraints
    }
    
    /**
     
     Convenience method to programmatically create `NSLayoutConstraint`s to align two `UIView`s.
     
     - parameter view: The first item in the created `NSLayoutConstraint`s.
     - parameter to: The second item in the created `NSLayoutConstraint`s.
     - parameter withInsets: The `constant` parameter to align the two `UIView`s by. The negative values of `.bottom` and `.right` are used to match the common use of `UIEdgeInsets`. The default value is `UIEdgeInsetsZero`.
     
     - returns: An array of `NSLayoutConstraint`s, ordered: top, left, bottom, right.
     
    */
    static func constraintsToAlign(view view1:UIView, to view2:UIView, withInsets insets:UIEdgeInsets = UIEdgeInsetsZero) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Top,
            relatedBy:.Equal,
            toItem:view2,
            attribute:.Top,
            multiplier:1.0,
            constant:insets.top))
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Leading,
            relatedBy:.Equal,
            toItem:view2,
            attribute:.Leading,
            multiplier:1.0,
            constant:insets.left))
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Bottom,
            relatedBy:.Equal,
            toItem:view2,
            attribute:.Bottom,
            multiplier:1.0,
            constant:-insets.bottom))
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Trailing,
            relatedBy:.Equal,
            toItem:view2,
            attribute:.Trailing,
            multiplier:1.0,
            constant:-insets.right))
        
        return constraints
    }
}
