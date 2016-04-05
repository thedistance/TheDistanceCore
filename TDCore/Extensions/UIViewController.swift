//
//  UIViewController.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

import SafariServices

public extension UIApplication {
    
    /// - returns: The response of `canOpenURL(_:)` as an `NSNumber` so the result can be accessed from the result of a `performSelector(...)`.
    public func number_canOpenURL(url:NSURL) -> NSNumber {
        return NSNumber(bool: canOpenURL(url))
    }
}

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
        } else {
            return self
        }
    }
}

extension UIViewController: SFSafariViewControllerDelegate {
    
    /**

     Convenience method for opening an `NSURL` in a browser, giving the user a choice of opening either Google Chrome or Safari. If Safari is chosen, this calls `openInSafari(_:)`.
     
     - note: As of iOS 9, `googlechrome` and `googlechromes` should be added to the `LSApplicationQueriesSchemes` key in `info.plist` in order to open in Chrome to work.
     
     - parameter url: The `NSURL` to open in a browser.
     - parameter item: Either the `UIView` or `UIBarButtonItem` that the `ActionSheet` style `UIAlertController` will be presented from on Regular-Regular size class devices.
     - paramter inViewController: The `UIViewController` that will present the `UIAlertController`. If `nil`, `self` is used to present the `UIAlertController`. The default value is `nil`.
     
     -seealso: `openInSafari(_:)`
     -seealso: `presentViewController(_:fromSourceItem:inViewController:animated:completion)`.
    */
    public func openURL(url:NSURL, fromSourceItem item:UIPopoverSourceType, inViewController:UIViewController? = nil) {

            
            if let chromeURL = url.googleChromeURL() where self.canOpenURL(NSURL(string: "googlechrome://")!) {
                
                let alert = UIAlertController(title: nil, message: "Open with...", preferredStyle: UIAlertControllerStyle.ActionSheet)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Safari", style: .Default, handler: { (action) -> Void in
                    self.openInSafari(url)
                }))
                
                alert.addAction(UIAlertAction(title: "Google Chrome", style: .Default, handler: { (action) -> Void in
                    self.openURL(chromeURL)
                }))
                
                self.presentViewController(alert, fromSourceItem: item)
                
            } else {
                openInSafari(url)
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

    /**
     
     Opens the specified `NSURL` in Safari, or presents an `SFSafariViewController` if called on iOS 9. The presented `SFSafariViewController` has `self` as its delegate and is dismissed on the `SFSafariViewControllerDelegate` method, `safariViewControllerDidFinish(_:)`.
     
     - parameter url: The `NSURL` to open.
    */
    public func openInSafari(url:NSURL) {
        
        if #available(iOS 9, *) {
            let vc = SFSafariViewController(URL: url)
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: nil)
            return
        }
        
        if self.canOpenURL(url) {
            self.openURL(url)
        }
    }
    
    /// Simple `SFSafariViewControllerDelegate` implementation that dismisses a presented `SFSafariViewController`.
    @available(iOS 9.0, *)
    public func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}