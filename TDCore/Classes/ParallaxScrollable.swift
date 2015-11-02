//
//  ParallaxScrollable.swift
//  TDCore
//
//  Created by Josh Campion on 02/11/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import Foundation

/**
 
 Protocol extending `UIScrollViewDelegate` to adjust the scrolling of a given view to mimic a parallax motion between the two views.
 
 Default implementations are given for `parallaxScrollViewDidScroll(_:)` on all adopters, and for `configureParallaxScrollInset(_:)` for `UIViewController`s.
 
 */
protocol ParallaxScrollable: UIScrollViewDelegate {
    
    /// The reference view that the `UIScrollView` will scroll over, whose position is adjusted on scrolling the `UIScrollView`.
    weak var headerView : UIView!  { get set }
    
    /// The `UIScrollView` whose offset drives the parallax motion of the `headerView`.
    weak var parallaxScrollView : UIScrollView!  { get set }
    
    /// The parallax motion of the `headerView` is implemented by setting the `constant` property of this constraint.
    weak var headerViewTopConstraint : NSLayoutConstraint!  { get set }
    
    /// Should set the `contentInset` of the `parallaxScrollView` to allow the `headerView` to be seen above the content of `parallaxScrollView`.
    func configureParallaxScrollInset(minimumHeight:CGFloat)
    
    /// Should update `headerViewTopConstraint.constant` to mimic a parallax motion.
    func parallaxScrollViewDidScroll(scrollView:UIScrollView)
}

extension ParallaxScrollable where Self:UIViewController {
    
    /// - returns: The intersection of `headerView` and `parallaxScrollView` in the frame of `parallaxScrollView.superview`.
    func headerOverlap() -> CGRect {
        
        guard let superview = parallaxScrollView.superview else { return CGRectZero }
        
        let headerInSuper = superview.convertRect(headerView.frame, fromView: headerView.superview)
        let intersection = CGRectIntersection(parallaxScrollView.frame, headerInSuper)
        
        return CGRectIntegral(intersection)
    }
    
    /// - returns: The intersection of `the bottomLayoutGuide` and `parallaxScrollView` in the frame of `parallaxScrollView.superview`.
    func bottomOverlap() -> CGRect {
        
        guard let superview = parallaxScrollView.superview else { return CGRectZero }
        
        let bottomInView = CGRectMake(0, view.frame.size.height - bottomLayoutGuide.length, view.frame.size.width, bottomLayoutGuide.length)
        let bottomInSuper = superview.convertRect(bottomInView, fromView: view)
        
        let intersection = CGRectIntersection(parallaxScrollView.frame, bottomInSuper)
        
        return CGRectIntegral(intersection)
    }
    
    /**

     Default implementation of `configureParallaxScrollInset(_:)` for `UIViewController`s.
     
     Sets the content inset of `parallaxScrollView` to allow the `headerView` to be fully visible above the content of the `parallaxScrollView`. The bottom inset of the `parallaxScrollView` is adjusted to allow the content to be visible above the `bottomLayoutGuide`. This will typically by called from `viewDidLayoutSubviews()`, to reset the `contentInset` as the size of other content changes.
    
     `headerOverlap()` and `bottomOverlap()` are used to calculate the necessary values.

     - paramter miniumHeight: The maximum of this and the value necessary for `headerView` to be fully visible above the content of the `parallaxScrollView` is the value assigned to `contentInset.top` on the `parallaxScrollView`.
    */
    func configureParallaxScrollInset(minimumHeight:CGFloat = 0) {
        
        let intersect = headerOverlap()
        let topInset = max(intersect.size.height, minimumHeight)
        if parallaxScrollView.contentInset.top <= topInset {
            var newInsets = parallaxScrollView.contentInset
            newInsets.top = topInset
            parallaxScrollView.contentInset = newInsets
        }
        
        let bottomIntersect = bottomOverlap()
        let bottomInset = max(0, bottomIntersect.size.height)
        if parallaxScrollView.contentInset.bottom <= bottomInset {
            var insets = parallaxScrollView.contentInset
            insets.bottom = bottomInset
            parallaxScrollView.contentInset = insets
        }
    }
}

extension ParallaxScrollable {
    
    /**
     
     Default implementation for parallax scrolling a header view. Typically this will be called from `scrollViewDidScroll:`.
     
     - parameter scrollView: The `UIScrollView` that has scrolled.
     - parameter scrollRate: The factor to mulitply the amount `scrollView` has scrolled by to get the parallax scroll amount. The default is 0.5.
     - parameter bouncesHeader: Flag to determine whether `headerView` should 'bounce' when `parallaxScrollView` bounces. This is achieved by setting negative values for `headerViewTopConstraint.constant`. The default value is `false`.
    */
    func parallaxScrollViewDidScroll(scrollView:UIScrollView, scrollRate:CGFloat = 0.5, bouncesHeader:Bool = false) {
        
        if scrollView == parallaxScrollView {
            
            let offset = scrollView.contentOffset.y + scrollView.contentInset.top
            let upScroll = bouncesHeader ? offset : max(offset, 0)
            var headerTop = scrollRate * upScroll
            headerTop = -floor(headerTop)
            
            if headerViewTopConstraint.constant != headerTop {
                headerViewTopConstraint.constant = headerTop
            }
        }
    }
}