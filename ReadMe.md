# TheDistanceCore

Develop faster with convenience functions from The Distance.

### Requirements

- iOS 8.0+
- Xcode 7.1+

### Communication

- If you have **found a bug**, open an issue.
- If you have **a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.
- If you'd like to **ask a general question**, email <dev+thedistancecore@thedistance.co.uk>.

### Installation

#### CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

    $ gem install cocoapods

CocoaPods 0.39.0+ is required to build TheDistanceCore as it is a Swift CocoaTouch Framework.

To integrate TheDistanceCore into your Xcode project using CocoaPods, specify it in your Podfile:

	platform :ios, '8.0'
	use_frameworks!

	pod 'TheDistanceCore'

Then, run the following command:

	$ pod install

###### Internal Development

This code is used in multiple live iOS projects. New features will be added during development and will go live only after discussions here. If you have access to our internal repos (i.e. you work here...) add the master repo to your project's Podfile

	# Master Pods Repo
    source 'https://github.com/CocoaPods/Specs.git'

    # Private Pods Repo
    source 'git@bitbucket.org:thedistance/thedistancekit-cocoapods.git'


### Features

Reducing boilerplate code is helps use to develop features faster and ensure they remain bug free, with platform updates and so we don't forget tricky edge cases. [TheDistance]() is an overarching project containing our stable reusable code. **TheDistanceCore** is a part of this project.

**TheDistanceCore** contains simple extensions and reusable classes that are in multiple projects. The purpose of this project is to contain small pieces of functionality that are very general. Specific code should be added to other [TheDistance]() sub-projects. 

Functionality includes:

- **Parallax Scroll**: Standard Protocol for implementing a 'parallax scroll' where one view moves based on a `UIScrollView`'s content offset.
- **Pure Swift Key-Value-Observing**: `NSObject`s implement a method called `methodSignatureForSelector:` which converts from strings to methods. Pure Swift classes do not have this method so cannot inherently perform KVO or observe `NSNotificationCenter` posts. **`Observer`**, **`ObjectObserver`**, and **`NotificationObserver`** resolve this.
- **`NSLayoutConstraint`s**: The default `NSLayoutConstraint` initialisers are clear but can be cumbersome when creating standard constraints. `constraintsToSize(...)` and `constraintsToAlign(...)` neaten the programmatic constraint creation process. Other convenience initialisers are provided.
- **Request Cache Control**: Not all APIs respond with 304 unmodified states when making requests with the `if-modified-since` header. It can be useful to impose a fixed time limit between the same network requests. The `RequestCache` protocol simplifies checking time intervals since successful requests.

Other features include:

- User friendly `NSError`s from networking operations.
- Neater syntax for Swift Dictionary creation when using `.map({ ... })`.
- Shortened Syntax for whitespace trimmed Strings.
- Simplified URL opening for Google Chrome or Safari.
- Default date comparisons
- Standard device dependent rotations (iPhone +s and iPads rotate `.AllButUpsideDown`, iPhones locked to portrait)
- `CGRect`, `UIEdgeInsets` common calculations

### Coding Conventions

All code should be written in the latest version of Swift and be fully documented using correct mark up syntax. Where possible, unit tests should be written to confirm validity of the functionality. If this is not possible, demo apps should be created demonstrating the functionality allowing bugs to be isolated easily.