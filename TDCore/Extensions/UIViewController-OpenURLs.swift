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
    public func number_canOpenURL(url:URL) -> NSNumber {
        return NSNumber(value: canOpenURL(url))
    }
}

extension UIViewController {
    
    /**
     
     Convenience method for opening an `NSURL` in a browser, giving the user a choice of opening either Google Chrome or Safari. If Safari is chosen, this calls `openInSafari(_:)`.
     
     - note: As of iOS 9, `googlechrome` and `googlechromes` should be added to the `LSApplicationQueriesSchemes` key in `info.plist` in order to open in Chrome to work.
     
     - parameter url: The `NSURL` to open in a browser.
     - parameter item: Either the `UIView` or `UIBarButtonItem` that the `ActionSheet` style `UIAlertController` will be presented from on Regular-Regular size class devices.
     - paramter inViewController: The `UIViewController` that will present the `UIAlertController`. If `nil`, `self` is used to present the `UIAlertController`. The default value is `nil`.
     
     -seealso: `openInSafari(_:)`
     -seealso: `presentViewController(_:fromSourceItem:inViewController:animated:completion)`.
     */
    public func openURL(url:URL, fromSourceItem item:UIPopoverSourceType, inViewController:UIViewController? = nil) {
        
        
        if let chromeURL = url.googleChromeURL(), self.canOpenURL(url: URL(string: "googlechrome://")! as NSURL) {
            
            let alert = UIAlertController(title: nil, message: "Open with...", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Safari", style: .default, handler: { (action) -> Void in
                self.openInSafari(url:url)
            }))
            
            alert.addAction(UIAlertAction(title: "Google Chrome", style: .default, handler: { (action) -> Void in
                self.openURL(url: chromeURL as NSURL)
            }))
            
            self.presentViewController(alert, fromSourceItem: item)
            
        } else {
            openInSafari(url:url)
        }
    }
    
    /**
     
     Opens the specified `NSURL` in Safari, or presents an `SFSafariViewController` if called on iOS 9. The presented `SFSafariViewController` has `self` as its delegate and is dismissed on the `SFSafariViewControllerDelegate` method, `safariViewControllerDidFinish(_:)`.
     
     - parameter url: The `NSURL` to open.
     */
    public func openInSafari(url:URL) {
        
//        if #available(iOS 9, *) {
//            let vc = SFSafariViewController(url: url)
//            vc.delegate = self
//            self.present(vc, animated: true, completion: nil)
//            return
//        }
        
        if self.canOpenURL(url:url as NSURL) {
            self.openURL(url:url as NSURL)
        }
    }
    
    /// Simple `SFSafariViewControllerDelegate` implementation that dismisses a presented `SFSafariViewController`.
//    @available(iOS 9.0, *)
//    public func safariViewControllerDidFinish(controller: SFSafariViewController) {
//        controller.dismiss(animated:true, completion: nil)
//    }
}
