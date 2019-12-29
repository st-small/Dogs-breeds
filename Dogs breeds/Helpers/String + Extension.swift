//
//  String + Extension.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func prepareBoldAttributedString() -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: 18.0)
        let color = UIColor.black
        return prepareAttributedString(font, color)
    }
    
    func prepareRegularAttributedString() -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 16)
        let color = UIColor.black
        let attributes =
            [NSAttributedString.Key.font: font,
             NSAttributedString.Key.foregroundColor: color]
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func prepareAttributedString(_ font: UIFont, _ color: UIColor) -> NSMutableAttributedString {
        let attributes =
            [NSAttributedString.Key.font: font,
             NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    func prepareStrikethroughAttributedString(_ font: UIFont, _ color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.font: font,
             NSAttributedString.Key.foregroundColor: color,
             NSAttributedString.Key.strikethroughStyle: 2]
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    func base64ToImage() -> UIImage? {
        
        if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
            return image
        }
        
        return nil
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.width)
    }
}

