//
//  CustomLayoutRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol CustomLayoutRoutingLogic {
    func routeToInfo(_ breedId: String)
}

public protocol CustomLayoutDataPassing {
    var dataStore: CustomLayoutDataStore? { get }
}

public class CustomLayoutRouter: NSObject, CustomLayoutRoutingLogic, CustomLayoutDataPassing {
    
    public weak var viewController: CustomLayoutViewController?
    public var dataStore: CustomLayoutDataStore?
    
    // MARK: - Routing
    public func routeToInfo(_ breedId: String) {
        let detail = BreedInfoViewController()
        var destinationDS = detail.router!.dataStore!
        passDataShowBreedDetails(source: dataStore!, destination: &destinationDS, breedId: breedId)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    
    // MARK: - Passing data
    private func passDataShowBreedDetails(source: CustomLayoutDataStore, destination: inout BreedInfoDataStore, breedId: String) {
        guard let breed = source.breeds.first(where: { $0.id == breedId }) else { return }
        destination.breed = breed
    }
}
