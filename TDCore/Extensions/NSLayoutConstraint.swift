//
//  NSLayoutConstraint.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

/// Constraints are said to be equal if both first and second items are `NSObject`s that are equal, and that the attributes, mulipliers, constants and priorities are equal
public func ==(c1:NSLayoutConstraint, c2:NSLayoutConstraint) -> Bool {
    
    guard let fi1 = c1.firstItem as? NSObject,
        let fi2 = c2.firstItem as? NSObject,
        let si1 = c1.secondItem as? NSObject?,
        let si2 = c2.secondItem as? NSObject?
        else {
            return false
    }
    
    return fi1 == fi2 &&
        si1 == si2 &&
        c1.relation == c2.relation &&
        c1.firstAttribute == c2.firstAttribute &&
        c1.secondAttribute == c2.secondAttribute &&
        c1.multiplier == c2.multiplier &&
        c1.constant == c2.constant &&
        c1.priority == c2.priority
    
}

public func !=(c1:NSLayoutConstraint, c2:NSLayoutConstraint) -> Bool {
    return !(c1 == c2)
}

/// Uses `==` on the constraints in the two arrays. This allows `isEqual(_:)` to remain unchanged for `NSLayoutConstraint` but allows two constraint arrays to be compared.
public func ==(c1:[NSLayoutConstraint], c2:[NSLayoutConstraint]) -> Bool {
    
    guard c1.count == c2.count else { return false }
    
    for (n, c) in c1.enumerate() {
        let other = c2[n]
        
        if other != c {
            return false
        }
    }
    
    return true
}

/// Uses `==` on the constraints in the two arrays. This allows `isEqual(_:)` to remain the unchanged for `NSLayoutConstraint` but allows two arrays to be compared.
public func !=(c1:[NSLayoutConstraint], c2:[NSLayoutConstraint]) -> Bool {
    
    return !(c1 == c2)
}



public extension NSLayoutConstraint {
    
    /**
     
     Convenience method to programmatically create an `NSLayoutConstraint` to size a given `UIView` to a ratio.
     
     - parameter view: The `UIView` the returned constraint is configure to.
     - parameter ratio: The height to width ratio expressed as a multiplier, i.e. 4:3 = 0.75.
     
     - returns: An array of `NSLayoutConstraint`s ordered width, height.
     
     */
    public static func constraintToSizeView(view:UIView, toRatio ratio:CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: view,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Width,
            multiplier: ratio,
            constant: 0.0)

    }
    
    /**
     
     Convenience method to programmatically create `NSLayoutConstraint`s to size a given `UIView` to a fixed height, width or both.

     - parameter view: The `UIView` the returned constraints are configure to.
     - parameter toWidth: If not `nil`, an `NSLayoutConstraint` configured to size the `view` to this width is created.
     - parameter andHeight: If not `nil`, an `NSLayoutConstraint` configured to size the `view` to this height is created.
     
     - returns: An array of `NSLayoutConstraint`s ordered width, height.
     
    */
    public static func constraintsToSize(view:UIView, toWidth width:CGFloat?, andHeight height:CGFloat?) -> [NSLayoutConstraint] {
        
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
     - parameter relativeToMargin: Tuple of `Bool`s for whether each constraint should be relative to the margin or not. Default is all false.
     
     - returns: An array of `NSLayoutConstraint`s, ordered: top, left, bottom, right.
     
    */
    public static func constraintsToAlign(view view1:UIView, to view2:UIView, withInsets insets:UIEdgeInsets = UIEdgeInsetsZero, relativeToMargin:(top:Bool, left:Bool, bottom:Bool, right:Bool) = (false, false, false, false)) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        let topAttribute:NSLayoutAttribute = relativeToMargin.top ? .TopMargin : .Top
        let leadingAttribute:NSLayoutAttribute = relativeToMargin.left ? .LeadingMargin : .Leading
        let bottomAttribute:NSLayoutAttribute = relativeToMargin.bottom ? .BottomMargin : .Bottom
        let trailingAttribute:NSLayoutAttribute = relativeToMargin.right ? .TrailingMargin : .Trailing
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Top,
            relatedBy:.Equal,
            toItem:view2,
            attribute:topAttribute,
            multiplier:1.0,
            constant:insets.top))
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Leading,
            relatedBy:.Equal,
            toItem:view2,
            attribute:leadingAttribute,
            multiplier:1.0,
            constant:insets.left))
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Bottom,
            relatedBy:.Equal,
            toItem:view2,
            attribute:bottomAttribute,
            multiplier:1.0,
            constant:-insets.bottom))
        
        constraints.append(NSLayoutConstraint(item:view1,
            attribute:.Trailing,
            relatedBy:.Equal,
            toItem:view2,
            attribute:trailingAttribute,
            multiplier:1.0,
            constant:-insets.right))
        
        return constraints
    }
}
