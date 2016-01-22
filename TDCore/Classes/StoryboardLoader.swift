//
//  StoryboardLoader.swift
//  Pods
//
//  Created by Josh Campion on 22/01/2016.
//
//

import Foundation

/**
 
 Protocol to be adopted by a class that gives easy loading of `UIViewController`s from multiple `UIStoryboard`s.

 Two enum types are specified that should be used to identify each `UIViewController` and that can be loaded from each `UIStoryboard`. The app specific adopter should then implement:
 
 - `storyboardIdentifierForViewControllerIdentifier(_:)`
 
 typically using a `switch` statement, to ensure exhaustive coverage of all view controllers declared at compile time. There is a defualt implementation for
 
 - `instantiateViewControllerForIdentifier(_:bundle:)`.
 
 that should not need to be overriden.
 
 There are defualt implementations for
 
 - `storyboardNameForIdentifier(_:)`
 - `viewControllerNameForIdentifier(_:)`
 
 where the enum types are backed by strings. These return the enum `rawValue`s in those implementations.
 
*/
public protocol StoryboardLoader {
    
    /// The enum type used to identify multiplie `UIStoryboard`s.
    typealias StoryboardIdentifierType: RawRepresentable
    
    // The enum type used to identify `UIViewController`s in `UIStoryboard`s
    typealias ViewControllerIdentifierType: RawRepresentable
    
    /// Should return the filename for the given identifier to be used in `UIStoryboard(name:bundle:)`. Default implementation when `StoryboardIdentifierType.RawValue == String` returns `storyboardID.rawValue`.
    static func storyboardNameForIdentifier(storyboardID:StoryboardIdentifierType) -> String

    /// Should return the `UIViewController` storyboard identifier for the given identifier to be used in `UIStoryboard.instantiateViewControllerWithIdentifier(_:)`. Default implementation when `ViewControllerIdentifierType.RawValue == String` returns `viewControllerID.rawValue`.
    static func viewControllerNameForIdentifier(viewControllerID:ViewControllerIdentifierType) -> String
    
    /// Should return the `StoryboardIdentifierType` that identifies the storyboard containing the `UIViewController` with the given identifier.
    static func storyboardIdentifierForViewControllerIdentifier(viewControllerID:ViewControllerIdentifierType) -> StoryboardIdentifierType
    
    /**

      Default implementation provided to instantiates a `UIViewController` an enum, without needing knowledge of the `UIStoryboard` containing this `UIViewController` and point of writing the loading code. 
     
     - parameter identifier: Shuold uniquely identify a `UIStoryboard` to load.
     - parameter bundle: Optional bundle that contains the `UIStoryboard`. In the defualt implementation, this is optional and the default value is nil.
     - returns: A newly instantiated `UIViewController`. This crashes is there is no `UIViewController` with the given identifier in the `UIStoryboard` identified by `storyboardIdentifierForViewControllerIdentifier`.

    */
    static func instantiateViewControllerForIdentifier(identifier:ViewControllerIdentifierType, bundle:NSBundle?) -> UIViewController
}

public extension StoryboardLoader {
    
    static public func instantiateViewControllerForIdentifier(viewControllerID:ViewControllerIdentifierType, bundle:NSBundle? = nil) -> UIViewController {
        
        let storyboardID = storyboardIdentifierForViewControllerIdentifier(viewControllerID)
        let storyboardName = storyboardNameForIdentifier(storyboardID)
        let viewControllerName = viewControllerNameForIdentifier(viewControllerID)
        
        return UIStoryboard(name: storyboardName, bundle: bundle).instantiateViewControllerWithIdentifier(viewControllerName)
    }
    
}

public extension StoryboardLoader where Self.StoryboardIdentifierType.RawValue == String {
    
    static public func storyboardNameForIdentifier(storyboardID:StoryboardIdentifierType) -> String {
        return storyboardID.rawValue
    }
    
}

public extension StoryboardLoader where Self.ViewControllerIdentifierType.RawValue == String {
    
    static public func viewControllerNameForIdentifier(viewControllerID:ViewControllerIdentifierType) -> String {
        return viewControllerID.rawValue
    }
    
}
