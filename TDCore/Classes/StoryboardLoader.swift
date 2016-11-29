//
//  StoryboardLoader.swift
//  Pods
//
//  Created by Josh Campion on 22/01/2016.
//
//

import UIKit

/**
 
 Protocol to be adopted by a class that gives easy loading of `UIViewController`s from multiple `UIStoryboard`s.

 Two enum types are specified that should be used to identify each `UIViewController` and the Storyboard from which it can be loaded. The app specific adopter should then implement:
 
 - `storyboardIdentifierForViewControllerIdentifier(_:)`
 
 typically using a `switch` statement, to ensure exhaustive coverage of all `UIViewControllers` declared at compile time. There is a defualt implementation for
 
 - `instantiateViewControllerForIdentifier(_:bundle:)`.
 
 that should not need to be overriden.
 
 There are defualt implementations for
 
 - `storyboardNameForIdentifier(_:)`
 - `viewControllerNameForIdentifier(_:)`
 
 where the enum types are backed by strings. These return the enum `rawValue`s in those implementations.
 
*/
public protocol StoryboardLoader {
    
    /// The enum type used to identify multiplie `UIStoryboard`s.
    associatedtype StoryboardIdentifierType: RawRepresentable
    
    // The enum type used to identify `UIViewController`s in `UIStoryboard`s
    associatedtype ViewControllerIdentifierType: RawRepresentable
    
    /// Should return the filename for the given identifier to be used in `UIStoryboard(name:bundle:)`. Default implementation when `StoryboardIdentifierType.RawValue == String` returns `storyboardID.rawValue`.
    static func storyboardNameForIdentifier(_ storyboardID:StoryboardIdentifierType) -> String

    /// Should return the `UIViewController` storyboard identifier for the given identifier to be used in `UIStoryboard.instantiateViewControllerWithIdentifier(_:)`. Default implementation when `ViewControllerIdentifierType.RawValue == String` returns `viewControllerID.rawValue`.
    static func viewControllerNameForIdentifier(_ viewControllerID:ViewControllerIdentifierType) -> String
    
    /// Should return the `StoryboardIdentifierType` that identifies the storyboard containing the `UIViewController` with the given identifier.
    static func storyboardIdentifierForViewControllerIdentifier(_ viewControllerID:ViewControllerIdentifierType) -> StoryboardIdentifierType
    
    /**
     
     Should create a new view controller from its containing Storyboard. A default implementation is provided.
     
     - parameter identifier: Should uniquely identify a `UIStoryboard` to load.
     - parameter bundle: Optional bundle that contains the `UIStoryboard`. In the defualt implementation, this is optional and the default value is nil.
     - returns: A newly instantiated `UIViewController`. This crashes if there is no `UIViewController` with the given identifier in the `UIStoryboard` identified by `storyboardIdentifierForViewControllerIdentifier(_:)`.

    */
    static func instantiateViewControllerForIdentifier(_ identifier:ViewControllerIdentifierType, bundle:Bundle?) -> UIViewController
}

public extension StoryboardLoader {
    
    /// Default implementation provided to instantiate a `UIViewController` an enum, without needing knowledge of the `UIStoryboard` containing this `UIViewController` at the point of the loading code.
    static public func instantiateViewControllerForIdentifier(_ viewControllerID:ViewControllerIdentifierType, bundle:Bundle? = nil) -> UIViewController {
        
        let storyboardID = storyboardIdentifierForViewControllerIdentifier(viewControllerID)
        let storyboardName = storyboardNameForIdentifier(storyboardID)
        let viewControllerName = viewControllerNameForIdentifier(viewControllerID)
        
        return UIStoryboard(name: storyboardName, bundle: bundle).instantiateViewController(withIdentifier: viewControllerName)
    }
    
}

public extension StoryboardLoader where Self.StoryboardIdentifierType.RawValue == String {
    
    /// Returns the String rawValue of the identifier enum.
    static public func storyboardNameForIdentifier(_ storyboardID:StoryboardIdentifierType) -> String {
        return storyboardID.rawValue
    }
    
}

public extension StoryboardLoader where Self.ViewControllerIdentifierType.RawValue == String {
    
    /// Returns the String rawValue of the identifier enum.
    static public func viewControllerNameForIdentifier(_ viewControllerID:ViewControllerIdentifierType) -> String {
        return viewControllerID.rawValue
    }
    
}
