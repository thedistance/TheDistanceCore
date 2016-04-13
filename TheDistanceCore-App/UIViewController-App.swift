//
//  UIViewController-App.swift
//  TDCore
//
//  Created by Josh Campion on 05/04/2016.
//  Copyright © 2016 The Distance. All rights reserved.
//

import UIKit

public extension UIViewController {

    /// - returns: Whether or not the shared `UIApplication` can open the given `NSURL`.
    public func canOpenURL(url:NSURL) -> Bool {
        return UIApplication.sharedApplication().canOpenURL(url)
    }

    /// Passes the given URL to the shared `UIApplication` to attempt to open.
    public func openURL(url:NSURL) {
        UIApplication.sharedApplication().openURL(url)
    }
    
}