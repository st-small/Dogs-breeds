//
//  StretchyHeaderLayout.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collection = collectionView else { return nil }
        let layoutAttributes = super.layoutAttributesForElements(in: rect)! as [UICollectionViewLayoutAttributes]
        
        let offset = collection.contentOffset
        if offset.y < 0 {
            let deltaY = -offset.y
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = max(0, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
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
