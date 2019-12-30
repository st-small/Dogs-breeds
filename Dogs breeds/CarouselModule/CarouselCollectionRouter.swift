//
//  CarouselCollectionRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol CarouselCollectionRoutingLogic {
    func routeToInfo(_ breedId: String)
}

public protocol CarouselCollectionDataPassing {
    var dataStore: CarouselCollectionDataStore? { get }
}

public class CarouselCollectionRouter: NSObject, CarouselCollectionRoutingLogic, CarouselCollectionDataPassing {
    public weak var viewController: CarouselCollectionViewController?
    public var dataStore: CarouselCollectionDataStore?
    
    // MARK: - Routing
    public func routeToInfo(_ breedId: String) {
        let detail = BreedInfoViewController()
        var destinationDS = detail.router!.dataStore!
        passDataShowBreedDetails(source: dataStore!, destination: &destinationDS, breedId: breedId)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    
    // MARK: - Passing data
    private func passDataShowBreedDetails(source: CarouselCollectionDataStore, destination: inout BreedInfoDataStore, breedId: String) {
        guard let breed = source.breeds.first(where: { $0.id == breedId }) else { return }
        destination.breed = breed
    }
}
