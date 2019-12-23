//
//  BreedItem.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 23.12.2019.
//  Copyright © 2019 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public struct BreedItem: Codable {
    public let id: Int
    public let name: String
    public let bredFor: String?
    public let breedGroup: String?
    public let height: Size
    public let lifeSpan: String
    public let origin: String?
    public let temperament: String?
    public let weight: Size
    public let breedItemDescription: String?
    public let history: String?
}
