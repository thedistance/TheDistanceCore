//
//  UIViewController.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    
    /**

     Convenience method for accessing the topmost presented view controller. This is useful when trying in initiate an action, such as a present action, from a UIView subclass that is independent of the `UIViewController` it is residing in.
     
     - returns: The `.rootViewController` of the `UIApplication`'s `keyWindow`, or the highest presented view controller. This will return `nil` if and only if there is no root view controller.
    */
    /*
    public class func topPresentedViewController() -> UIViewController? {
        
        var context = UIApplication.sharedApplication().keyWindow?.rootViewController
        while context?.presentedViewController != nil {
            context = context?.presentedViewController
        }
        
        return context
    }
    */
     
    /**
     
     Convenience method for handling nested `UIViewController`s in a `UISplitViewController` or other situation where a navigation controller may be passed, not the specific `UIViewController` subclass that contains the 'content'.
     
     - returns: The root `UIViewController` if `self` is  a `UINavigationController` or `self` if not.
     */
    public func navigationRootViewController() -> UIViewController? {
        if let nav = self as? UINavigationController {
            return nav.viewControllers.first
        } else if let split = self as? UISplitViewController {
            return split.viewControllers.first?.navigationRootViewController()
        } else {
            return self
        }
    }
    
    /**
     
     Convenience method for handling nested `UIViewController`s in a `UISplitViewController` or other situation where a navigation controller may be passed, not the specific `UIViewController` subclass that contains the 'content'.
     
     - returns: The top most `UIViewController` in the stack if `self` is  a `UINavigationController` or `self` if not.
     */
    public func navigationTopViewController() -> UIViewController? {
        if let nav = self as? UINavigationController {
            return nav.viewControllers.last
        } else if let split = self as? UISplitViewController {
            return split.viewControllers.last?.navigationTopViewController()
        } else {
            return self
        }
    }
    
    /**
     
     Convenience method for presenting a `UIViewController` configuring the `popoverPresentationController` to use a given `UIView` or `UIBarButtonItem`. This is useful for action sheets and `UIActivityViewController`s.
     
     - parameter vc: The `UIViewController` to present.
     - parameter item: Either the `UIView` or `UIBarButtonItem` that the `ActionSheet` style `UIAlertController` will be presented from on Regular-Regular size class devices.
     - paramter inViewController: The `UIViewController` that will present the `UIAlertController`. If `nil`, `self` is used to present the `UIAlertController`. The default value is `nil`.
     - parameter animated: Passed to `presentViewController(_:animated:completion:)`
     - parameter completion: Passed to `presentViewController(_:animated:completion:)`
     
     -seealso: `openInSafari(_:)`
     */
    public func presentViewController(vc:UIViewController, fromSourceItem item: UIPopoverSourceType, inViewController:UIViewController? = nil, animated:Bool = true, completion: (() -> ())? = nil) {
        
        switch item {
        case .View(let view):
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController?.sourceRect = view.bounds
        case .BarButton(let item):
            vc.popoverPresentationController?.barButtonItem = item
        }
        
        (inViewController ?? self).presentViewController(vc, animated: animated, completion: completion)
    }
}

