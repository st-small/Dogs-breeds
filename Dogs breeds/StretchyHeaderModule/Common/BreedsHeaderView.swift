//
//  BreedsHeaderView.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class StretchyHeaderView: UICollectionReusableView {
    
    public static let reuseId = "StretchyHeaderView"
    
    // MARK: - UI elements
    private var headerImage: UIImageView = {
        let image = UIImage(named: "headerBackground")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var headerLogo: UIImageView = {
        let image = UIImage(named: "headerLogo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public var backgroundImageHeight: CGFloat = 0
    public var foregroudImageHeight: CGFloat = 0
    public var previousHeight: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        
        backgroundImageHeight = headerImage.bounds.height
        foregroudImageHeight = headerLogo.bounds.height
        
        addSubview(headerImage)
        headerImage.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(840)
        }
        
        addSubview(headerLogo)
        headerLogo.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.width.equalTo(headerLogo.snp.height).multipliedBy(0.72)
        }
    }
    
    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attributes = layoutAttributes as? StretchyHeaderAttributes else { return }
        let height = attributes.frame.height
        if previousHeight != height {
            headerImage.snp.updateConstraints { make in
                make.height.equalTo(backgroundImageHeight - attributes.deltaY)
            }
            headerLogo.snp.updateConstraints { make in
                make.height.equalTo(foregroudImageHeight + attributes.deltaY)
            }
            previousHeight = height
        }
    }
}
