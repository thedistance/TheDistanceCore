# TDCore

General extensions to speed up development.

### Requirements

- iOS 8.0+
- Xcode 7.1+

### Communication

- If you have **found a bug**, open an issue.
- If you have **a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.
- If you'd like to **ask a general question**, email <dev+tdcore@thedistance.co.uk>.

### Installation

#### CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

    $ gem install cocoapods

CocoaPods 0.39.0+ is required to build TDCore as it is a Swift CocoaTouch Framework.

To integrate TDCore into your Xcode project using CocoaPods, specify it in your Podfile:

	platform :ios, '8.0'
	use_frameworks!

	pod 'TDCore', '~> 1.0'

Then, run the following command:

	$ pod install

### Features

At The Distance, we have multiple projects with common functionality. Shared implementations ensure these features are developed concisely and remain bug free. TheDistanceKit is the overarching project containing this reusable code.

TDCore contains simple extensions and re-usable classes that are in multiple projects completed by The Distance. The purpose of this project is to contain small pieces of functionality that are very general. Specific code should be added to other **TheDistanceKit** sub-projects. 

All code should be written in the latest version of Swift and be fully documented using correct mark up syntax. Where possible, unit tests should be written to confirm validity of the functionality.

Functionality includes:

- **Parallax Scroll**: Standard Protocol for implementing a 'parallax scroll' where one view moves based on a `UIScrollView`'s content offset.
- **Pure Swift Key-Value-Observing**: `NSObject`s implement a method called `methodSignatureForSelector:` which converts from strings to methods. Pure Swift classes do not have this method so cannot inherently perform KVO or observe `NSNotificationCenter` posts. **`Observer`**, **`ObjectObserver`**, and **`NotificationObserver`** resolve this.
- **Programmatic `NSLayoutConstraint` Simplification**: The default `NSLayoutConstraint` initialisers are clear but can be cumbersome when creating standard constraints. `constraintsToSize(...)` and `constraintsToAlign(...)` neaten the programmatic constraint creation process. A value based equality of constraints is also implemented.

Other features include:

- User friendly `NSError`s from networking operations.
- Neater syntax for Swift Dictionary creation when using `.map({ ... })`.
- Shortened Syntax for whitespace trimmed Strings.
- Simplified URL opening for Google Chrome or Safari. 

