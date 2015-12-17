//
//  GradientView.swift
//  Pods
//
//  Created by Josh Campion on 17/12/2015.
//
//

import UIKit

public enum GradientDirection: Equatable {
    case Vertical
    case Horizontal
    case Custom(startPoint:CGPoint, endPoint:CGPoint)
}

public func ==(g1:GradientDirection, g2:GradientDirection) -> Bool {
    
    switch (g1, g2) {
    case (.Vertical, .Vertical):
        return true
    case (.Horizontal, .Horizontal):
        return true
    case (.Custom(let start1, let end1), .Custom(let start2, let end2)):
        return CGPointEqualToPoint(start1, start2) && CGPointEqualToPoint(end1, end2)
    default:
        return false
    }
}

@IBDesignable
public class GradientView: UIView {
    
    @IBInspectable
    public var horizontal:Bool? = nil {
        didSet {
            if let hValue = horizontal {
                direction = hValue ? .Horizontal : .Vertical
            }
        }
    }
    
    @IBInspectable
    public var startColour:UIColor? {
        didSet {
            if let start = startColour,
                let end = endColour {
                    colours = [start, end]
            }
        }
    }
    
    @IBInspectable
    public var endColour:UIColor? {
        didSet {
            if let start = startColour,
                let end = endColour {
                    colours = [start, end]
            }
        }
    }
    
    public var direction:GradientDirection = .Vertical {
        didSet {
            guard direction != oldValue else { return }
                
            switch direction {
            case .Vertical:
                gradientLayer.startPoint = CGPointMake(0.5, 0)
                gradientLayer.endPoint = CGPointMake(0.5, 1)
            case .Horizontal:
                gradientLayer.startPoint = CGPointMake(0, 0.5)
                gradientLayer.endPoint = CGPointMake(1, 0.5)
            case .Custom(startPoint: let start, endPoint: let end):
                gradientLayer.startPoint = start
                gradientLayer.endPoint = end
            }
            
            setNeedsDisplay()
        }
    }
    
    public var colours = [UIColor]() {
        didSet {
            gradientLayer.colors = colours.map({ $0.CGColor })
        }
    }
    
    public var locations = [CGFloat]() {
        didSet {
            gradientLayer.locations = locations
        }
    }
    
    public private(set) var gradientLayer = CAGradientLayer()
    
    private var oldSize = CGSizeZero
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        if gradientLayer.superlayer == nil {
            layer.addSublayer(gradientLayer)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        if gradientLayer.superlayer == nil {
            layer.addSublayer(gradientLayer)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        if !CGSizeEqualToSize(oldSize, bounds.size) {
            gradientLayer.frame = bounds
            oldSize = bounds.size
        }
    }
}