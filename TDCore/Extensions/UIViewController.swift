//
//  UIViewController.swift
//  Interchange
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 Interchange Management Ltd. All rights reserved.
//

import Foundation

import SafariServices

public extension UIViewController {
    
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
    */
    public func openURL(url:NSURL, fromSourceItem item:UIPopoverSourceType, inViewController:UIViewController? = nil) {
        if let chromeURL = url.googleChromeURL() where UIApplication.sharedApplication().canOpenURL(NSURL(string: "googlechrome://")!) {
            
            let alert = UIAlertController(title: nil, message: "Open with...", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Safari", style: .Default, handler: { (action) -> Void in
                self.openInSafari(url)
            }))
            
            alert.addAction(UIAlertAction(title: "Google Chrome", style: .Default, handler: { (action) -> Void in
                UIApplication.sharedApplication().openURL(chromeURL)
            }))
            
            switch item {
            case .View(let view):
                alert.popoverPresentationController?.sourceView = view
                alert.popoverPresentationController?.sourceRect = view.bounds
            case .BarButton(let item):
                alert.popoverPresentationController?.barButtonItem = item
            }
            alert.popoverPresentationController
            
            
            (inViewController ?? self).presentViewController(alert, animated: true, completion: nil)
            
        } else {
            openInSafari(url)
        }
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
            
        } else if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @available(iOS 9.0, *)
    public func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}