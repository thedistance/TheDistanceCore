//
//  Enums.swift
//  TDCore
//
//  Created by Josh Campion on 30/10/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import UIKit

/**
 
 Enum to pass to methods that can present a `UIViewController` modally from multiple sources.
 This removes the the need for providing two APIs or specifying `AnyObject` as the parameter type and maintains type safety.
 
 - seealso: `openURL(_:fromSourceItem:inViewController:)`
 
 */
public enum UIPopoverSourceType {
    /// Specifies to popover from the associated `UIBarButtonItem`.
    case barButton(UIBarButtonItem)
    /// Specifies to popover from the associated `UIView`.
    case view(UIView)
}
