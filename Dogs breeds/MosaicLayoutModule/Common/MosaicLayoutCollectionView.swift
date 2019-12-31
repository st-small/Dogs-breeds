//
//  MosaicLayoutCollectionView.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MosaicLayoutCollectionDelegate: class {
    func breedSelected(_ breedId: String)
}

public class MosaicLayoutCollectionView: UICollectionView {
    
    private var breeds = [BreedItemModel]()
    public weak var cellDelegate: MosaicLayoutCollectionDelegate?
    
    // MARK: - Collection view constants
    private let columns: CGFloat = 3.0
    private let inset: CGFloat = 8.0
    private let spacing: CGFloat = 8.0
    private let lineSpacing: CGFloat = 8.0
    
    public init() {
        
        let layout = MosaicViewLayout()
        layout.numberOfColumns = 2
        layout.cellPadding = 5
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        layout.delegate = self
        
        backgroundColor = #colorLiteral(red: 0.7129858136, green: 0.8651095629, blue: 0.9885597825, alpha: 1)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        register(MosaicLayoutCollectionViewCell.self, forCellWithReuseIdentifier: MosaicLayoutCollectionViewCell.reuseId)
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

extension MosaicLayoutCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breeds.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = breeds[indexPath.item]
        let cell = dequeueReusableCell(withReuseIdentifier: MosaicLayoutCollectionViewCell.reuseId, for: indexPath) as! MosaicLayoutCollectionViewCell
        let name = model.breeds.compactMap({ $0.name }).first ?? ""
        let descriptions = model.breeds.compactMap({ $0.temperament })
        let description = descriptions.filter({ !$0.isEmpty }).first ?? "Breed hasn't any description yet."
        cell.set(image: model.url, title: name, description: description)
        
        return cell
    }
}

extension MosaicLayoutCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breed = breeds[indexPath.item]
        cellDelegate?.breedSelected(breed.id)
    }
}

extension MosaicLayoutCollectionView: UICollectionViewDelegateFlowLayout {
    
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

extension MosaicLayoutCollectionView: MosaicLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                               heightForImageAt indexPath: IndexPath,
                               width: CGFloat) -> CGFloat {
        let breedImage = breeds[indexPath.item]
        let imgWidth = CGFloat(breedImage.width)
        let imgHeight = CGFloat(breedImage.height)
        
        return width/imgWidth * imgHeight
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               heightForDescriptionAt indexPath: IndexPath,
                               width: CGFloat) -> CGFloat {
        let breedsValues = breeds[indexPath.item].breeds
        let titleFont = UIFont.boldSystemFont(ofSize: 18)
        let titleHeight = heightText(breedsValues.first?.name ?? "", font: titleFont, width: width - 24)
        
        let descriptionValues = breedsValues.compactMap({ $0.temperament })
        let description = descriptionValues.filter({ !$0.isEmpty }).first ?? "Breed hasn't any description yet."
        let descriptionFont = UIFont.systemFont(ofSize: 16)
        let descriptionHeight = heightText(description, font: descriptionFont, width: width - 24)
        let height = 8 + titleHeight + 4 + descriptionHeight + 12
        
        return height
    }
    
    private func heightText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: text).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        
        return ceil(rect.height)
    }
}
