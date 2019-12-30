//
//  BreedVerticalCell.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import SDWebImage
import UIKit

public class BreedVerticalCell: UICollectionViewCell {
    
    public static let reuseId = "BreedVerticalCell"
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
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
        elementsContainer.layer.borderWidth = 6.0
        elementsContainer.layer.borderColor = UIColor.white.cgColor
    }
    
    private func configureImage() {
        elementsContainer.addSubview(breedImage)
        breedImage.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(elementsContainer.snp.width)
        }
    }

    private func configureTitle() {
        addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(breedImage.snp.bottom)
        }
    }

    public override func prepareForReuse() {
        breedImage.image = nil
    }

    public func set(image: String, title: String) {
        breedImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        breedImage.sd_setImage(with: URL(string: image))
        titleLabel.attributedText = title.prepareBoldAttributedString()

        configureImage()
        configureTitle()
    }
}
