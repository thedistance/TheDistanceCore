//
//  ParallaxScrollable.swift
//  TDCore
//
//  Created by Josh Campion on 02/11/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import UIKit

/**
 
 Protocol extending `UIScrollViewDelegate` to adjust the scrolling of a given view to mimic a parallax motion between the two views.
 
 Default implementations are given for `parallaxScrollViewDidScroll(_:)` on all adopters, and for `configureParallaxScrollInset(_:)` for `UIViewController`s.
 
 */
public protocol ParallaxScrollable: UIScrollViewDelegate {
    
    /// The reference view that the `UIScrollView` will scroll over, whose position is adjusted on scrolling the `UIScrollView`.
    var parallaxHeaderView: UIView!  { get }
    
    /// The `UIScrollView` whose offset drives the parallax motion of the `headerView`.
    var parallaxScrollView: UIScrollView!  { get set }
    
    /// The mask applied to the `parallaxHeaderView` that provides clipping of `parallaxHeaderView` if the content of a `parallaxScrollView` is short enough for the `parallaxHeaderView` to be visible underneath the scrollable content.
    var parallaxHeaderMask: CAShapeLayer { get }
    
    /// The parallax motion of the `headerView` is implemented by setting the `constant` property of this constraint.
    var parallaxHeaderViewTopConstraint : NSLayoutConstraint!  { get set }
    
    /// Should set the `contentInset` of the `parallaxScrollView` to allow the `headerView` to be seen above the content of `parallaxScrollView`.
    func configureParallaxScrollInset(minimumHeight:CGFloat)
    
    /// Should update `headerViewTopConstraint.constant` to mimic a parallax motion. With the given parameter. A default implementation is given.
    func parallaxScrollViewDidScroll(scrollView:UIScrollView, scrollRate:CGFloat, bouncesHeader:Bool, maskingHeader:Bool)
}


public extension ParallaxScrollable where Self:UIViewController {
    
    /// - returns: The intersection of `the bottomLayoutGuide` and `parallaxScrollView` in the frame of `parallaxScrollView.superview`.
    public func parallaxBottomOverlap() -> CGRect {
        
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

     - parameter miniumHeight: The maximum of this and the value necessary for `headerView` to be fully visible above the content of the `parallaxScrollView` is the value assigned to `contentInset.top` on the `parallaxScrollView`.
    */
    public func configureParallaxScrollInset(minimumHeight:CGFloat = 0) {
        
        let intersect = parallaxHeaderView.frame // parallaxHeaderOverlap()
        let topInset = max(intersect.size.height, minimumHeight)
        if parallaxScrollView.contentInset.top != topInset {
            var newInsets = parallaxScrollView.contentInset
            newInsets.top = topInset
            parallaxScrollView.contentInset = newInsets
        }
        
        // bottom inset is only increased, not set so that the content is visible over the bottom layout guide but the inset isn't decreased for things such as a keyboard being onscreen.
        let bottomIntersect = parallaxBottomOverlap()
        let bottomInset = max(0, bottomIntersect.size.height)
        if parallaxScrollView.contentInset.bottom <= bottomInset {
            var insets = parallaxScrollView.contentInset
            insets.bottom = bottomInset
            parallaxScrollView.contentInset = insets
        }
        
        updateParallaxHeaderMask()
    }
}

public extension ParallaxScrollable {

    /// - returns: The intersection of `headerView` and `parallaxScrollView` in the frame of `parallaxScrollView.superview`.
    public func parallaxHeaderOverlap() -> CGRect {
        
        guard let superview = parallaxScrollView.superview else { return CGRectZero }
        
        let headerInSuper = superview.convertRect(parallaxHeaderView.frame, fromView: parallaxHeaderView.superview)
        let intersection = CGRectIntersection(parallaxScrollView.frame, headerInSuper)
        
        return CGRectIntegral(intersection)
    }
    
    /**
     
     Default implementation for parallax scrolling a header view. Typically this will be called from `scrollViewDidScroll:`.
     
     - parameter scrollView: The `UIScrollView` that has scrolled.
     - parameter scrollRate: The factor to mulitply the amount `scrollView` has scrolled by to get the parallax scroll amount. The default is 0.5.
     - parameter bouncesHeader: Flag to determine whether `headerView` should 'bounce' when `parallaxScrollView` bounces. This is achieved by setting negative values for `headerViewTopConstraint.constant`. The default value is `false`.
     - parameter maskingHeader: Flag to determine whether `headerView` should be masked by `parallaxScrollView`'s `contentOffset`. The default value is `true`.
    */
    public func parallaxScrollViewDidScroll(scrollView:UIScrollView, scrollRate:CGFloat = 0.5, bouncesHeader:Bool = false, maskingHeader:Bool = true) {
        
        if scrollView == parallaxScrollView {
            
            let offset = scrollView.contentOffset.y + scrollView.contentInset.top
            let upScroll = bouncesHeader ? offset : max(offset, 0)
            var headerTop = scrollRate * upScroll
            headerTop = -floor(headerTop)
            
            if parallaxHeaderViewTopConstraint.constant != headerTop {
                parallaxHeaderViewTopConstraint.constant = headerTop
            }
            
            updateParallaxHeaderMask()
        }
    }
    
    /// Updates `parallaxHeaderMask` to clip the `parallaxHeaderView`, preventing it being seen beneath short content.
    public func updateParallaxHeaderMask() {
        // mask the header view by the scroll view
        let absOffset = -parallaxHeaderViewTopConstraint.constant
        let headerSize = parallaxHeaderView.frame.size
        let visibleRect = CGRectMake(0, absOffset, headerSize.width, headerSize.height - 2.0 * absOffset)
        
        parallaxHeaderMask.frame = parallaxHeaderView.bounds
        parallaxHeaderMask.path = UIBezierPath(rect: visibleRect).CGPath
        
        parallaxHeaderMask.fillColor = UIColor.blackColor().CGColor
        if parallaxHeaderView.layer.mask == nil {
            parallaxHeaderView.layer.mask = parallaxHeaderMask
        }
    }
}
