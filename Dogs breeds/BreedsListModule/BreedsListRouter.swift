//
//  BreedsListRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 23.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol BreedsListRoutingLogic {
    func routeToInfo(_ breedId: String)
}

public protocol BreedsListDataPassing {
    var dataStore: BreedsListDataStore? { get }
}

public class BreedsListRouter: NSObject, BreedsListRoutingLogic, BreedsListDataPassing {
    
    public weak var viewController: BreedsListViewController?
    public var dataStore: BreedsListDataStore?
    
    // MARK: - Routing
    public func routeToInfo(_ breedId: String) {
        let detail = BreedInfoViewController()
        var destinationDS = detail.router!.dataStore!
        passDataShowBreedDetails(source: dataStore!, destination: &destinationDS, breedId: breedId)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    
    // MARK: - Passing data
    private func passDataShowBreedDetails(source: BreedsListDataStore, destination: inout BreedInfoDataStore, breedId: String) {
        guard let breed = source.breeds.first(where: { $0.id == breedId }) else { return }
        destination.breed = breed
    }
}
