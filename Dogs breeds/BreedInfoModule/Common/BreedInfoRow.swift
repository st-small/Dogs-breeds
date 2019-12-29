//
//  BreedInfoRow.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class BreedInfoRow: UIView {
    
    // MARK: - UI elements
    private var rowDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var rowText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private func configureDescription(_ value: String) {
        rowDescription.attributedText = value.prepareBoldAttributedString()
        let font = UIFont.boldSystemFont(ofSize: 18.0)
        let width = value.width(height: 20, font: font)
        addSubview(rowDescription)
        rowDescription.snp.remakeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(width)
        }
    }
    
    private func configureText(_ value: String) {
        rowText.attributedText = value.prepareRegularAttributedString()
        addSubview(rowText)
        rowText.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(rowDescription.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public func setup(title: String, text: String) {
        configureDescription(title)
        configureText(text)
    }
}
