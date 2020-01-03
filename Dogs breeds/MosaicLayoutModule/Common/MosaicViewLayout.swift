//
//  MosaicViewLayout.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MosaicLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        heightForImageAt indexPath: IndexPath,
                        width: CGFloat) -> CGFloat
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForDescriptionAt indexPath: IndexPath,
                        width: CGFloat) -> CGFloat
}

public class MosaicLayoutAttributes: UICollectionViewLayoutAttributes {
    
    public var imageHeight: CGFloat = 0
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        guard let copy = super.copy(with: zone) as? MosaicLayoutAttributes else { return MosaicLayoutAttributes() }
        copy.imageHeight = imageHeight
        
        return copy
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? MosaicLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        
        return false
    }
}

public class MosaicViewLayout: UICollectionViewLayout {
    
    public var numberOfColumns = 0
    public weak var delegate: MosaicLayoutDelegate?
    public var cellPadding: CGFloat = 0
    public var cache = [MosaicLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    public override class var layoutAttributesClass: AnyClass {
        return MosaicLayoutAttributes.self
    }
    
    public override var collectionViewContentSize : CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    public override func prepare() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let width = columnWidth - cellPadding * 2
                let imageHeight = delegate?.collectionView(collectionView!, heightForImageAt: indexPath, width: width) ?? 0
                let descriptionHeight = delegate?.collectionView(collectionView!, heightForDescriptionAt: indexPath, width: width) ?? 0
                let height = cellPadding + imageHeight + descriptionHeight + cellPadding
                
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = MosaicLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.imageHeight = imageHeight
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
