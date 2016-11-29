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
        return false
//        var responder = self.next
//        while responder != nil {
//            
//            if responder is UIApplication {
//                break
//            } else {
//                responder = responder?.next
//            }
//        }
//        
//        if let application = responder as? UIApplication {
//            let result = application.performSelector(inBackground: Selector("number_canOpenURL:"), with: url)
//            return (result.takeUnretainedValue() as? Bool) ?? false
//        }
//        
//        return false
    }
    
    public func openURL(url:NSURL) {
        return
//        var responder = self.next
//        while responder != nil {
//            
//            if responder is UIApplication {
//                break
//            } else {
//                responder = responder?.next
//            }
//        }
//        
//        if let application = responder as? UIApplication {
//            application.performSelector(inBackground: #selector(UIViewController.openURL(_:)), with: url)
//            return
//        }
    }
    
}
