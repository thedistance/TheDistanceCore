//
//  UIViewController-Extension.swift
//  TDCore
//
//  Created by Josh Campion on 05/04/2016.
//  Copyright © 2016 The Distance. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// - returns: Whether or not the shared `UIApplication` can open the given `NSURL`.
    public func canOpenURL(url:NSURL) -> Bool {
        
        var responder = self.nextResponder()
        while responder != nil {
            
            if responder is UIApplication {
                break
            } else {
                responder = responder?.nextResponder()
            }
        }
        
        if let application = responder as? UIApplication {
            let result = application.performSelector(Selector("number_canOpenURL:"), withObject: url)
            return (result?.takeUnretainedValue() as? Bool) ?? false
        }
        
        return false
    }
    
    public func openURL(url:NSURL) {
        
        var responder = self.nextResponder()
        while responder != nil {
            
            if responder is UIApplication {
                break
            } else {
                responder = responder?.nextResponder()
            }
        }
        
        if let application = responder as? UIApplication {
            application.performSelector(#selector(UIViewController.openURL(_:)), withObject: url)
            return
        }
    }
    
}
