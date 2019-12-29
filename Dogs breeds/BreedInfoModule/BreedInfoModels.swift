//
//  BreedInfoModels.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public enum BreedInfo {
    public enum Model {
        public enum Request {
            case getInfo
        }
        public enum Response {
            case presentInfo(_ breedInfo: BreedItemModel)
        }
        public enum ViewModel {
            case displayInfo(_ breedInfo: BreedInfoViewModel)
        }
    }
}
