//
//  ClassicCollectionCell.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import SDWebImage
import UIKit

public class ClassicCollectionCell: UICollectionViewCell {
    
    public static let reuseId = "ClassicCollectionCell"
    
    // MARK: - UI elements
    private var breedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureImage() {
        addSubview(breedImage)
        breedImage.snp.remakeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureTitle() {
        prepareMask()
        addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    public override func prepareForReuse() {
        breedImage.image = nil
    }
    
    public func set(image: String, title: String) {
        breedImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        breedImage.sd_setImage(with: URL(string: image))
        titleLabel.text = title
        
        configureImage()
        configureTitle()
    }
    
    private func prepareMask() {
        let y = bounds.maxY - 50
        let maskedView = UIView(frame: CGRect(x: 0, y: y, width: bounds.width, height: 50))
        maskedView.backgroundColor = UIColor.black
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = maskedView.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientMaskLayer.locations = [0, 1]
        maskedView.layer.mask = gradientMaskLayer
        addSubview(maskedView)
        
        maskedView.translatesAutoresizingMaskIntoConstraints = false
        maskedView.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
