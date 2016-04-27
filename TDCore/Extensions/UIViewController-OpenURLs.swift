//
//  UIViewController-OpenURLs.swift
//  TDCore
//
//  Created by Josh Campion on 13/04/2016.
//  Copyright © 2016 The Distance. All rights reserved.
//

import UIKit

import TheDistanceCore
import SafariServices

public extension UIApplication {
    
    /// - returns: The response of `canOpenURL(_:)` as an `NSNumber` so the result can be accessed from the result of a `performSelector(...)`.
    public func number_canOpenURL(url:NSURL) -> NSNumber {
        return NSNumber(bool: canOpenURL(url))
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