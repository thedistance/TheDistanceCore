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
    func scaledToMaxDimension(_ dim: CGFloat) -> UIImage {
        
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
    func scaledImageToSize(_ size: CGSize) -> UIImage {
        
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
    func scaledImage(_ sx:CGFloat, sy: CGFloat) -> UIImage {
        
        let scaledSize = CGSize(width: size.width * sx, height: size.height * sy)
        
        let cgImg = self.cgImage
        let ctx = CGContext(data: nil, width: Int(scaledSize.width), height: Int(scaledSize.height),
                                        bitsPerComponent: cgImg!.bitsPerComponent, bytesPerRow: 0,
                                        space: cgImg!.colorSpace!,
                                        bitmapInfo: cgImg!.bitmapInfo.rawValue)
        
        ctx!.draw(cgImg!, in: CGRect(x: 0,y: 0,width: scaledSize.width, height: scaledSize.height))
        let newImage = UIImage(cgImage:ctx!.makeImage()!)
        
        return newImage
    }
    
    /**
     
     A new `UIImage` created from applying a transform to the image in a CGContext. The rotation of the image is no longer stored in image meta data which is useful for uploading images to servers which don't interpret the meta data.
     
     - returns: The rotated image.
     
    */
    public func orientationNeutralImage() -> UIImage! {
        
        // No-op if the orientation is already correct
        if (self.imageOrientation == .up) {
            return self
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform = CGAffineTransform.identity
        
        switch (self.imageOrientation) {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi))
            
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi))
        default:
            transform = transform.concatenating(CGAffineTransform.identity)
        }
        
        switch (self.imageOrientation) {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            transform = transform.concatenating(CGAffineTransform.identity)
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
            bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
            space: self.cgImage!.colorSpace!,
            bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        
        ctx!.concatenate(transform)
        
        switch (self.imageOrientation) {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx!.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        default:
            ctx!.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx!.makeImage()
        let img = UIImage(cgImage:cgimg!)
        
        return img
    }
}
