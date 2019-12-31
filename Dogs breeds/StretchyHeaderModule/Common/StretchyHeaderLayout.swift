//
//  StretchyHeaderLayout.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class StretchyHeaderAttributes: UICollectionViewLayoutAttributes {
    
    public var deltaY: CGFloat = 0
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        guard let copy = super.copy(with: zone) as? StretchyHeaderAttributes else { return StretchyHeaderAttributes() }
        copy.deltaY = deltaY
        
        return copy
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? StretchyHeaderAttributes {
            if attributes.deltaY == deltaY {
                return super.isEqual(object)
            }
        }
        
        return false
    }
}

public class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    public var maximumStretchHeight: CGFloat = 0
    
    public override class var layoutAttributesClass: AnyClass {
        return StretchyHeaderAttributes.self
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collection = collectionView else { return nil }
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect)! as? [StretchyHeaderAttributes] else { return nil }
        
        let offset = collection.contentOffset
        if offset.y < 0 {
            let deltaY = -offset.y
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = min(max(0, headerReferenceSize.height + deltaY), maximumStretchHeight)
                        frame.origin.y = frame.minY - deltaY
                        attributes.deltaY = deltaY
                        attributes.frame = frame
                    }
                }
            }
        }
        
        return layoutAttributes
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
