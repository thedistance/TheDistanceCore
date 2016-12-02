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
        //NSExtensionContext doesnt implement canOpenURL
        //return self.extensionContext?.canOpenURL(url as URL)
        return true
    }
    
    /// Passes the given URL to the shared `UIApplication` to attempt to open.
    public func openURL(url:NSURL) {
        self.extensionContext?.open(url as URL)
        //do{
        //    try self.sharedApplication().performSelector(inBackground: #selector(UIApplication.openURL(_:)), with: url)
        //} catch {
        //
        //}
    }
    
    public func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }
            
            responder = responder?.next
        }
        
        throw NSError(domain: "UIViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
    
}
