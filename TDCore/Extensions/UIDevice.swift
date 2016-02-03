//
//  UIDevice.swift
//  TheDistanceCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

public extension UIDevice {
    
    /**
     
     Returns the supported interface orientations based on the device.
     
     - returns: iPads and iPhone '+' s return `.AllButUpsideDown`, other iPhones return `.Portrait`.
     
     */
    public func getDeviceSupportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad || UIScreen.mainScreen().scale > 2.1 {
            return .AllButUpsideDown
        } else {
            return .Portrait
        }
    }
}