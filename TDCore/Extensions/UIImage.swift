//
//  UIImage.swift
//  Pods
//
//  Created by Josh Campion on 16/02/2016.
//
//

import UIKit

public extension UIImage {
    
    /**
     
     Creates a new image scaled to maintain the curent aspect ratio where the scaled image will have a maximum dimension of the given size.
     
     - seealso: `scaledImage(_:sy:)`
     - seealso: `scaledToMaxDimension(_:)`
     
     - parameter dim: The maximum size of either the width or height of the scaled image.
     
     - returns: The scaled image.
     
     */
    func scaledToMaxDimension(dim: CGFloat) -> UIImage {
        
        let ratio = dim / max(size.width, size.height)
        return scaledImage(ratio, sy: ratio)
    }
    
    /**
     
     Creates a new image scaled to the exact size given.
     
     - seealso: `scaledImage(_:sy:)`
     - seealso: `scaledToMaxDimension(_:)`
     
     - parameter size: The size in px to create this image.
     
     - returns: The scaled image.
    */
    func scaledImageToSize(size: CGSize) -> UIImage {
        
        let sx = size.width / self.size.width
        let sy = size.height / self.size.height
        
        return scaledImage(sx, sy: sy)
    }
    
    /**
     
     Creates a new image in a `CGBitMapContext` scaled to the given proportions.
     
     - seealso: `scaledImageToSize(_:)`
     - seealso: `scaledToMaxDimension(_:)`
     
     - returns: The scaled image.
    */
    func scaledImage(sx:CGFloat, sy: CGFloat) -> UIImage {
        
        let scaledSize = CGSizeMake(size.width * sx, size.height * sy)
        
        let cgImg = self.CGImage
        let ctx = CGBitmapContextCreate(nil, Int(scaledSize.width), Int(scaledSize.height),
                                        CGImageGetBitsPerComponent(cgImg), 0,
                                        CGImageGetColorSpace(cgImg),
                                        CGImageGetBitmapInfo(cgImg).rawValue)
        
        CGContextDrawImage(ctx, CGRectMake(0,0,scaledSize.width, scaledSize.height), cgImg)
        let newImage = UIImage(CGImage:CGBitmapContextCreateImage(ctx)!)
        
        return newImage
    }
    
    /**
     
     A new `UIImage` created from applying a transform to the image in a CGContext. The rotation of the image is no longer stored in image meta data which is useful for uploading images to servers which don't interpret the meta data.
     
     - returns: The rotated image.
     
    */
    public func orientationNeutralImage() -> UIImage! {
        
        // No-op if the orientation is already correct
        if (self.imageOrientation == .Up) {
            return self
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform = CGAffineTransformIdentity
        
        switch (self.imageOrientation) {
        case .Down, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            
        case .Left,.LeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            
            
        case .Right, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        default:
            transform = CGAffineTransformConcat(transform, CGAffineTransformIdentity)
        }
        
        switch (self.imageOrientation) {
        case .UpMirrored, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            
            
        case .LeftMirrored, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
        default:
            transform = CGAffineTransformConcat(transform, CGAffineTransformIdentity)
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGBitmapContextCreate(nil, Int(self.size.width), Int(self.size.height),
            CGImageGetBitsPerComponent(self.CGImage), 0,
            CGImageGetColorSpace(self.CGImage),
            CGImageGetBitmapInfo(self.CGImage).rawValue)
        
        CGContextConcatCTM(ctx, transform)
        
        switch (self.imageOrientation) {
        case .Left, .LeftMirrored, .Right, .RightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage)
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage)
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = CGBitmapContextCreateImage(ctx)
        let img = UIImage(CGImage:cgimg!)
        
        return img
    }
}