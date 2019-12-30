//
//  CarouselCollectionView.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol CarouselCollectionDelegate: class {
    func breedSelected(_ breedId: String)
}

public class CarouselCollectionView: UICollectionView {
    
    private var breeds = [BreedItemModel]()
    private var currentCard: Int = 0
    public weak var cellDelegate: CarouselCollectionDelegate?
    
    public init() {
        
        let width = UIScreen.main.bounds.width * 0.8
        
        let layout = CarouselFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width + 100)
        layout.minimumLineSpacing = -layout.itemSize.height * (1 - layout.standartItemScale)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = #colorLiteral(red: 0.7129858136, green: 0.8651095629, blue: 0.9885597825, alpha: 1)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(BreedVerticalCell.self, forCellWithReuseIdentifier: BreedVerticalCell.reuseId)
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

extension CarouselCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breeds.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = breeds[indexPath.item]
        let cell = dequeueReusableCell(withReuseIdentifier: BreedVerticalCell.reuseId, for: indexPath) as! BreedVerticalCell
        let name = model.breeds.compactMap({ $0.name }).first ?? ""
        cell.set(image: model.url, title: name)
        
        return cell
    }
}

extension CarouselCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item == currentCard else { return }
        let breed = breeds[indexPath.item]
        cellDelegate?.breedSelected(breed.id)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BreedsHeaderView.reuseId, for: indexPath)
        return header
    }
}

extension CarouselCollectionView: UIScrollViewDelegate {
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
