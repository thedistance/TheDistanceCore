//
//  GMDPopOverView.swift
//  TDCore
//
//  Created by Josh Campion on 22/12/2015.
//  Copyright © 2015 The Distance. All rights reserved.
//

import UIKit
import TZStackView

public typealias GMDPopoverAction = (title:String, handler:(title:String) -> Void)

public class GMDPopOverView: UIView {

    public let titleLabel = UILabel()
    public let messageLabel = UILabel()
    public let buttons:[UIButton]

    public let chrome = UIView()
    
    private let actions:[String:GMDPopoverAction]
    
    
    private let stack:TZStackView
    private let buttonStack:TZStackView
    
    required public init?(coder aDecoder: NSCoder) {
        
        buttonStack = TZStackView(arrangedSubviews: [])
        stack = TZStackView(arrangedSubviews: [titleLabel, messageLabel, buttonStack])
        
        buttons = []
        self.actions = [String:GMDPopoverAction]()
        
        super.init(coder: aDecoder)
        
        configureViews()
        createHierarchy()
    }
    
    required public init(title:String?, message:String?, actions:[GMDPopoverAction]) {
        
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.hidden = title == nil
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.hidden = message == nil
        
        self.actions = Dictionary(actions.map({ ($0.title, $0) }))
        
        buttons = actions.map({ (action: GMDPopoverAction) -> UIButton in
            
            let button = UIButton(type: .System)
            button.setTitle(action.title, forState: .Normal)
            
            return button
        })
        
        let padding = UIView()
        padding.setContentHuggingPriority(249, forAxis: .Horizontal)
        
        buttonStack = TZStackView(arrangedSubviews: [padding] + buttons)
        buttonStack.hidden = buttons.count == 0
        
        stack = TZStackView(arrangedSubviews: [titleLabel, messageLabel, buttonStack])
        
        super.init(frame: CGRectMake(0, 0, 50, 50))
        
        // add targets after init otherwise self is used before super.init
        buttons.forEach({ $0.addTarget(self, action: "actionTapped:", forControlEvents: .TouchUpInside) })
        
        configureViews()
        createHierarchy()
    }

    public func configureViews() {
        
        let prio:UILayoutPriority = 1000
        self.setContentHuggingPriority(prio, forAxis: .Vertical)
        buttonStack.setContentHuggingPriority(prio, forAxis: .Vertical)
        stack.setContentHuggingPriority(prio, forAxis: .Vertical)
        
        titleLabel.setContentHuggingPriority(prio, forAxis: .Vertical)
        messageLabel.setContentHuggingPriority(prio, forAxis: .Vertical)
        buttons.forEach({ $0.setContentHuggingPriority(prio, forAxis: .Vertical) })
        
        buttonStack.spacing = 16.0
        buttonStack.axis = .Horizontal

        stack.spacing = 16.0
        stack.axis = .Vertical
        
        self.backgroundColor = UIColor.whiteColor()
        buttonStack.backgroundColor = UIColor.clearColor()
        stack.backgroundColor = UIColor.clearColor()
        chrome.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        chrome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "chromeTapped:"))
    }
    
    public func createHierarchy() {
        
        chrome.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: self,
            attribute: .Width,
            relatedBy: .LessThanOrEqual,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 0.0,
            constant: 600.0))
        
        addSubview(stack)
        addConstraints(NSLayoutConstraint.constraintsToAlign(view: stack, to: self, withInsets:UIEdgeInsetsMakeEqual(16)))
        
        // add and align chrome to self
        chrome.addSubview(self)
        
        let leading = NSLayoutConstraint(item: self,
            attribute: .Leading,
            relatedBy: .GreaterThanOrEqual,
            toItem: chrome,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 16.0)
        leading.priority = 990
        
        let trailing = NSLayoutConstraint(item: self,
            attribute: .Trailing,
            relatedBy: .LessThanOrEqual,
            toItem: chrome,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: -16.0)
        trailing.priority = 990
        
        let centers:[NSLayoutAttribute] = [.CenterX, .CenterY]
        let centerConstrs = centers.map {
            NSLayoutConstraint(item: self,
                attribute: $0,
                relatedBy: .Equal,
                toItem: chrome,
                attribute: $0,
                multiplier: 1.0,
                constant: 0)
        }
        
        chrome.addConstraints([leading, trailing])
        chrome.addConstraints(centerConstrs)
    }
    
    func actionTapped(sender:UIButton) {
        
        hide()
        
        if let title = sender.titleForState(.Normal),
            let action = actions[title] {
                action.handler(title: title)
        }
        
        
    }
    
    public func chromeTapped(tapper:UITapGestureRecognizer) {
        if tapper.state == .Recognized && !CGRectContainsPoint(bounds, tapper.locationInView(self)) {
            hide()
        }
    }
    
    public func show(animated:Bool = true, duration:NSTimeInterval = 0.15) {
        
        // configure to starting values
        self.alpha = 0.0
        self.transform = CGAffineTransformMakeScale(0.8, 0.8)
        chrome.alpha = 1.0
        
        // add to the window to create priority
        guard let window = UIApplication.sharedApplication().keyWindow else { return }
        
        window.addSubview(chrome)
        window.addConstraints(NSLayoutConstraint.constraintsToAlign(view:chrome, to:window))
        
        // animate / reset the appearance
        let animations = {
            self.alpha = 1.0
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            self.chrome.alpha = 1.0
        }
        
        if animated {
            UIView.animateWithDuration(duration, animations: animations)
        } else {
            animations()
        }
    }
    
    public func hide(animated:Bool = true, duration:NSTimeInterval = 0.15) {
        
        let animations = {
            self.alpha = 0.0
            self.transform = CGAffineTransformMakeScale(0.8, 0.8)
            
            self.chrome.alpha = 0.0
        }
        
        let completion = { (finished:Bool) -> () in
            self.chrome.removeFromSuperview()
        }
        
        if animated {
            UIView.animateWithDuration(duration, animations: animations, completion: completion)
        } else {
            animations()
            completion(true)
        }
        
        
    }
    
}
