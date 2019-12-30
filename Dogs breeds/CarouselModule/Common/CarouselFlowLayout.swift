//
//  CarouselFlowLayout.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    public let standartItemAlpha: CGFloat = 0.5
    public let standartItemScale: CGFloat = 0.5
    
    private var isSetup = false
    
    public override func prepare() {
        super.prepare()
        
        if !isSetup {
            setupCollectionView()
            isSetup = true
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
        }
        
        return attributesCopy
    }
    
    private func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collection = collectionView else { return }
        
        let safeAreaTop = collection.safeAreaInsets.top
        
        let collectionCenter = (collection.frame.height - safeAreaTop) / 2
        let offset = collection.contentOffset.y + safeAreaTop
        let normalizeCenter = attributes.center.y - offset
        
        let maxDistance = itemSize.height + minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizeCenter), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        let alpha = ratio * (1 - standartItemAlpha) + standartItemAlpha
        let scale = ratio * (1 - standartItemScale) + standartItemScale
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func setupCollectionView() {
        guard let collection = collectionView else { return }
        collection.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let collectionSize = collection.bounds.size
        let yInsetTop = (collectionSize.height - collection.safeAreaInsets.top - itemSize.height) / 2
        let yInsetBottom = yInsetTop - collection.safeAreaInsets.bottom
        let xInset = (collectionSize.width - itemSize.width) / 2
        
        sectionInset = UIEdgeInsets(top: yInsetTop, left: xInset, bottom: yInsetBottom, right: xInset)
    }
}
