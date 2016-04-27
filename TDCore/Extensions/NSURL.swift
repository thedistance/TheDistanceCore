//
//  NSURL.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

public extension NSURL {
    
    /**

     Creates an `NSURL` for opening in Google Chrome app. The caller should check whether the current `UIApplication` can open the returned value before attempting to.
     
     - note: As of iOS 9, `googlechrome` and `googlechromes` should be added to the `LSApplicationQueriesSchemes` key in `info.plist` in order to open the retuned Google Chrome URL.
     
     - returns: An `NSURL` suitable for opening an `NSURL` in Google Chrome if the scheme of `self` is `http` or `https`. `nil` otherwise.
    */
    public func googleChromeURL() -> NSURL? {
        
        guard scheme == "http" || scheme == "https" else { return nil }
        
        let urlComps = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)
        
        if scheme == "http" {
            urlComps?.scheme = "googlechrome"
        }
        
        if scheme == "https" {
            urlComps?.scheme = "googlechromes"
        }
        
        return urlComps?.URL
    }
    
}