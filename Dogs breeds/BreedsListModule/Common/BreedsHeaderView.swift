//
//  BreedsHeaderView.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class BreedsHeaderView: UICollectionReusableView {
    
    public static let reuseId = "BreedsHeaderView"
    
    // MARK: - UI elements
    private var headerImage: UIImageView = {
        let image = UIImage(named: "headerBackground")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var headerLogo: UIImageView = {
        let image = UIImage(named: "headerLogo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        clipsToBounds = true
        
        addSubview(headerImage)
        headerImage.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(headerLogo)
        headerLogo.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(180)
        }
    }
}
