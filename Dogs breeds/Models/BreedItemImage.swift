//
//  BreedItemImage.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 23.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public struct BreedItemImage: Codable {
    public let breeds: [BreedItem]
    public let id: String
    public let url: String
    public let width: Int
    public let height: Int
}
