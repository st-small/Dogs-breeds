//
//  MainModels.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public enum Main {
    public enum Model {
        public enum Request {
            case getMainData
        }
        public enum Response {
            case presentMainData(_ values: [String])
        }
        public enum ViewModel {
            case displayMainData(_ values: [String])
        }
    }
}
