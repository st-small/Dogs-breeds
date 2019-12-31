//
//  MainInteractor.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MainBusinessLogic {
    func makeRequest(request: Main.Model.Request)
}

public protocol MainDataStore {
    var collectionTypes: [String] { get set }
}

public class MainInteractor: MainBusinessLogic, MainDataStore {
    
    public var collectionTypes: [String] = ["Classic collection view",
                                            "Carousel collection view",
                                            "Stretchy header collection view",
                                            "Custom view layout collection view"]
    
    public var presenter: MainPresentationLogic?
    
    // MARK: - Main logic
    public func makeRequest(request: Main.Model.Request) {
        switch request {
        case .getMainData:
            presenter?.presentData(response: .presentMainData(collectionTypes))
        }
    }
}
