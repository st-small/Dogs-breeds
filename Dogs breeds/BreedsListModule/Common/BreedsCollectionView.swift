//
//  BreedsCollectionView.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 25.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol BreedsCollectionViewDelegate: class {
    func breedSelected(_ breedId: String)
}

public class BreedsCollectionView: UICollectionView {
    
    public var breeds = [BreedItemModel]()
    private var currentCard: Int = 0
    public weak var cellDelegate: BreedsCollectionViewDelegate?
    
    // MARK: - Collection view constants
    private let columns: CGFloat = 3.0
    private let inset: CGFloat = 8.0
    private let spacing: CGFloat = 8.0
    private let lineSpacing: CGFloat = 8.0
    
    public var isRandom = false
    
    public init() {
        
        let width = UIScreen.main.bounds.width * 0.8
        
        // Простой лейаут
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
        
        // Логика лейаута карусели
//        let layout = CarouselFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: width, height: width + 100)
//        layout.minimumLineSpacing = -layout.itemSize.height * (1 - layout.standartItemScale)
        
        // Stretchy
        let layout = StretchyHeaderLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
    
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = #colorLiteral(red: 0.7129858136, green: 0.8651095629, blue: 0.9885597825, alpha: 1)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(BreedCell.self, forCellWithReuseIdentifier: BreedCell.reuseId)
        register(BreedVerticalCell.self, forCellWithReuseIdentifier: BreedVerticalCell.reuseId)
        register(StretchyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StretchyHeaderView.reuseId)
    }
    
    public func set(breeds: [BreedItemModel]) {
        self.breeds = breeds
        contentOffset = .zero
        reloadData()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension BreedsCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breeds.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = breeds[indexPath.item]
        let cell = dequeueReusableCell(withReuseIdentifier: BreedCell.reuseId, for: indexPath) as! BreedCell
        let name = model.breeds.compactMap({ $0.name }).first ?? ""
        cell.set(image: model.url, title: name)
        
        // Карусель
//        let model = breeds[indexPath.item]
//        let cell = dequeueReusableCell(withReuseIdentifier: BreedVerticalCell.reuseId, for: indexPath) as! BreedVerticalCell
//        let name = model.breeds.compactMap({ $0.name }).first ?? ""
//        cell.set(image: model.url, title: name)
        
        return cell
    }
}

extension BreedsCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Carousel only
        //guard indexPath.item == currentCard else { return }
        let breed = breeds[indexPath.item]
        cellDelegate?.breedSelected(breed.id)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StretchyHeaderView.reuseId, for: indexPath)
        return header
    }
}

extension BreedsCollectionView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / columns - (inset + spacing))

        var randomSize: Int
        if isRandom {
            randomSize = 64 * Int(arc4random_uniform(3) + 1)
        } else {
            randomSize = width
        }

        return CGSize(width: randomSize, height: randomSize)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}

extension BreedsCollectionView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calcCurrentCard(scrollView: scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        calcCurrentCard(scrollView: scrollView)
    }
    
    private func calcCurrentCard(scrollView: UIScrollView) {
        guard let layout = collectionViewLayout as? CarouselFlowLayout else { return }
        
        let cardSize = layout.itemSize.height + layout.minimumLineSpacing
        let offset = scrollView.contentOffset.y + safeAreaInsets.top
        
        currentCard = Int(floor((offset - cardSize / 2) / cardSize) + 1)
    }
}
