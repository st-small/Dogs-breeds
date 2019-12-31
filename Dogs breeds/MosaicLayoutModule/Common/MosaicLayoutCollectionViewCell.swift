//
//  MosaicLayoutCollectionViewCell.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import SDWebImage
import UIKit

public class MosaicLayoutCollectionViewCell: UICollectionViewCell {
    
    public static let reuseId = "MosaicLayoutCollectionViewCell"
    
    // MARK: - UI elements
    private var elementsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9294117647, blue: 0.4980392157, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private var breedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    private var imageHeight: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(elementsContainer)
        elementsContainer.snp.remakeConstraints { make in
            make.height.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        elementsContainer.layer.cornerRadius = frame.width / 8
        elementsContainer.layer.borderWidth = 3.0
        elementsContainer.layer.borderColor = UIColor.white.cgColor
    }
    
    private func configureImage() {
        elementsContainer.addSubview(breedImage)
        breedImage.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageHeight)
        }
    }

    private func configureTitle() {
        addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(breedImage.snp.bottom).offset(8)
        }
    }
    
    private func configureDescription() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    public override func prepareForReuse() {
        breedImage.image = nil
    }

    public func set(image: String, title: String, description: String) {
        breedImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        breedImage.sd_setImage(with: URL(string: image))
        titleLabel.attributedText = title.prepareBoldAttributedString()
        descriptionLabel.attributedText = description.prepareRegularAttributedString()
        
        configureImage()
        configureTitle()
        configureDescription()
    }
    
    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attributes = layoutAttributes as? MosaicLayoutAttributes else { return }
        imageHeight = attributes.imageHeight
    }
}
