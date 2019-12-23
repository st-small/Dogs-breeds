//
//  BreedsListModels.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 23.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public enum BreedsList {
    public enum Model {
        public enum Request {
            case breeds
        }
        public enum Response {
            case presentBreeds(_ items: [BreedItemImage])
        }
        public enum ViewModel {
            case displayBreeds(_ items: [BreedItemImage])
        }
    }
}
