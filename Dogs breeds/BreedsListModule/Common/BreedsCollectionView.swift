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
    public weak var cellDelegate: BreedsCollectionViewDelegate?
    
    public init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = #colorLiteral(red: 0.4, green: 0.6862745098, blue: 1, alpha: 1)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(BreedCell.self, forCellWithReuseIdentifier: BreedCell.reuseId)
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
        
        return cell
    }
}

extension BreedsCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breed = breeds[indexPath.item]
        cellDelegate?.breedSelected(breed.id)
    }
}

extension BreedsCollectionView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 30
        let size = ceil(screenWidth/3)
        
        return CGSize(width: size, height: size)
    }
}
