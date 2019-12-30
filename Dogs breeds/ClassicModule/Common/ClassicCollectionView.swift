//
//  ClassicCollectionView.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol ClassicCollectionDelegate: class {
    func breedSelected(_ breedId: String)
}

public class ClassicCollectionView: UICollectionView {
    
    private var breeds = [BreedItemModel]()
    public weak var cellDelegate: ClassicCollectionDelegate?
    
    // MARK: - Collection view constants
    private let columns: CGFloat = 3.0
    private let inset: CGFloat = 8.0
    private let spacing: CGFloat = 8.0
    private let lineSpacing: CGFloat = 8.0
    
    public init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = #colorLiteral(red: 0.7129858136, green: 0.8651095629, blue: 0.9885597825, alpha: 1)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(ClassicCollectionCell.self, forCellWithReuseIdentifier: ClassicCollectionCell.reuseId)
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

extension ClassicCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breeds.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = breeds[indexPath.item]
        let cell = dequeueReusableCell(withReuseIdentifier: ClassicCollectionCell.reuseId, for: indexPath) as! ClassicCollectionCell
        let name = model.breeds.compactMap({ $0.name }).first ?? ""
        cell.set(image: model.url, title: name)
        
        return cell
    }
}

extension ClassicCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breed = breeds[indexPath.item]
        cellDelegate?.breedSelected(breed.id)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BreedsHeaderView.reuseId, for: indexPath)
        return header
    }
}

extension ClassicCollectionView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / columns - (inset + spacing))
        
        return CGSize(width: width, height: width)
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
