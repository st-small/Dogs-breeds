//
//  BreedInfoInteractor.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol BreedInfoBusinessLogic {
    func makeRequest(request: BreedInfo.Model.Request)
}

public protocol BreedInfoDataStore {
    var breed: BreedItemModel! { get set }
}

public class BreedInfoInteractor: BreedInfoBusinessLogic, BreedInfoDataStore {
    
    var presenter: BreedInfoPresentationLogic?
    
    public var breed: BreedItemModel!
    
    // MARK: - Main logic
    public func makeRequest(request: BreedInfo.Model.Request) {
        switch request {
        case .getInfo:
            guard let breed = breed else { return }
            presenter?.presentData(response: .presentInfo(breed))
        }
    }
}
