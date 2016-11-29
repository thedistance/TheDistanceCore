//
//  FittingGridFlowLayout.swift
//  Pods
//
//  Created by Josh Campion on 17/02/2016.
//
//

import UIKit

/// `UICollectionViewFlowLayout` subclass that shows items as grid that fit horizontally to a fixed margin rather than a fixed size. The size is determined by the `itemTargetWidth`, `singleColumnRatio` and `multiColumnRatio`. The target width may not be realized, but is used to determined the number of columns in the layout.
public class FittingGridFlowLayout: UICollectionViewFlowLayout {

    /// The actual number of items filling the width of the collection view given the itemTargetWidth, line spacing, item spacing and width of the collection view.
    private(set) public var columnCount:Int = 0
    
    /// The target width of all items in the grid. Default is 380. If the actual number of items that will fit given the item and line spacing is fractional, the number of items wide is the rounded value. The actual size of the items with therefore vary from this value in most cases. The height is determined by the singleColumnRatio and multiColumnRatio properties. Default is 380.0.
    public var itemTargetWidth:CGFloat = 380.0 {
        didSet {
            if itemTargetWidth != oldValue {
                invalidateLayout()
            }
        }
    }
    
    /// The ratio of the items if there is only a single column. Default is 0.5625.
    public var singleColumnRatio:CGFloat = 0.5625 {
        didSet {
            if singleColumnRatio != oldValue {
                invalidateLayout()
            }
        }
    }
    
    /// The ratio of the items if there are multiple columns. Default is 0.75.
    public var multiColumnRatio:CGFloat = 0.75 {
        didSet {
            if multiColumnRatio != oldValue {
                invalidateLayout()
            }
        }
    }
    
    /// Returns the number of items in a row based on the ratio properties given the contentWidth. In prepareLayout this method is called with the collectionView's bounds's width.
    public func columnCountForWidth(contentWidth:CGFloat) -> Int {
        
        let itemSpace = contentWidth - self.sectionInset.left - self.sectionInset.right
        let gap = self.minimumInteritemSpacing
        
        let count = Int(round((itemSpace + gap) / (self.itemTargetWidth + gap)))
        return max(count, 1)
    }
    
    /// Returns the item size of items based on the ratio properties given the contentWidth. In prepareLayout this method is called with the collectionView's bounds's width.
    public func itemSizeForWidth(contentWidth:CGFloat) -> CGSize {
        
        let itemSpace = contentWidth - self.sectionInset.left - self.sectionInset.right
        let gap = self.minimumInteritemSpacing
        
        let columnCount = columnCountForWidth(contentWidth)
        
        let itemSize:CGSize
        if (columnCount <= 1) {
            itemSize = CGSizeMake(itemSpace, self.singleColumnRatio * itemSpace);
        } else {
            let itemWidth = floor((itemSpace + gap) / CGFloat(columnCount) - gap);
            let itemHeight = floor(self.multiColumnRatio * itemWidth);
            itemSize = CGSizeMake(itemWidth, itemHeight);
        }
        
        return itemSize;
    }
    
    /// Calculates the column count for the size of the current `collectionView`, setting the `itemSize` based on `itemSizeForWidth(_:)`.
    override public func prepareLayout() {

        super.prepareLayout()
        
        guard let contentWidth = self.collectionView?.bounds.size.width else { return }
        
        columnCount = columnCountForWidth(contentWidth)
        self.itemSize = itemSizeForWidth(contentWidth)
    }
    
    /// Invalidates the layout based on whether or not the width of `newBounds` differs from that of the current `collectionView`.
    override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        guard let cv = self.collectionView else { return false }
        
        return newBounds.size.width != cv.bounds.size.width
    }
}