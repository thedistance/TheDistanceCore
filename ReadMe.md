# TheDistanceCore

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)

Develop faster with convenience functions from The Distance.

## Requirements

- iOS 8.0+
- Xcode 7.3
- Swift 2.2

## Features

Reducing boilerplate code helps us to develop features faster and ensure they remain bug free with platform updates and so we don't forget tricky edge cases. 

**TheDistanceCore** contains simple extensions and reusable classes that are referenced in multiple projects. The purpose of this project is to contain small pieces of functionality that are very general. More specific code, or code that has dependencies on other frameworks, should not be included here.

[Full Documentation](http://thedistance.github.io/TheDistanceCore/) is available on our GitHub Pages site.

Functionality includes:

- **Parallax Scroll**: Standard Protocol for implementing a 'parallax scroll' where one view moves based on a `UIScrollView`'s content offset.
- **Storyboard Loader**: Storyboards can easily become bloated and slow to load. Typically storyboards can be separated into related parts but managing which View Controller is where can be messy if done throughout the app. The `StoryboardLoader` protocol simplifies this by allowing you to define enums for your Storyboards and ViewControllers and instantiate them using `StoryboardLoader.instantiateViewControllerWithIdentifier(_:)`.
- **Pure Swift Key-Value-Observing**: `NSObject`s implement a method called `methodSignatureForSelector:` which converts from strings to methods. Pure Swift classes do not have this method so cannot inherently perform KVO or observe `NSNotificationCenter` posts. `Observer`,  `ObjectObserver`, and `NotificationObserver` resolve this.
- **NSLayoutConstraints**: The default `NSLayoutConstraint` initialisers are clear but can be cumbersome when creating standard constraints. `constraintsToSize(...)` and `constraintsToAlign(...)` neaten the programmatic constraint creation process. Other convenience initialisers are provided.
- **Request Cache Control**: Not all APIs respond with 304 unmodified states when making requests with the `if-modified-since` header. It can be useful to impose a fixed time limit between the same network requests. The `RequestCache` protocol simplifies checking time intervals since successful requests.
- **Extension Framework**: Framework version with API restricted to that suitable for an extension.

Other features include:

- User friendly `NSError`s from networking and location operations.
- Neater syntax for Swift Dictionary creation when using `.map({ ... })`.
- Shortened Syntax for whitespace trimmed Strings.
- Simplified URL opening for Google Chrome or Safari.
- Default date comparisons using comparison operators.
- Standard device dependent rotations (iPhone +s and iPads rotate `.AllButUpsideDown`, iPhones locked to portrait)
- `CGRect`, `UIEdgeInsets` common calculations.


## Communication

- If you have **found a bug**, open an issue.
- If you have **a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.
- If you'd like to **ask a general question**, email us on <hello+thedistancecore@thedistance.co.uk>.

## Installation

[Carthage](https://github.com/Carthage/Carthage) is the preferred dependency manager as it reduces build times during app development. TheDistanceCore has been built for Carthage. Add 
	
	github "TheDistance/TheDistanceCore"
	
to your cartfile and run
	
	carthage update TheDistanceCore
	
to build the framework. Add to it your project according to the Carthage instructions.

