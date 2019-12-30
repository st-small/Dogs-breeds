//
//  ClassicCollectionRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol ClassicCollectionRoutingLogic {
    func routeToInfo(_ breedId: String)
}

public protocol ClassicCollectionDataPassing {
    var dataStore: ClassicCollectionDataStore? { get }
}

public class ClassicCollectionRouter: NSObject, ClassicCollectionRoutingLogic, ClassicCollectionDataPassing {
    public weak var viewController: ClassicCollectionViewController?
    public var dataStore: ClassicCollectionDataStore?
    
    // MARK: - Routing
    public func routeToInfo(_ breedId: String) {
        let detail = BreedInfoViewController()
        var destinationDS = detail.router!.dataStore!
        passDataShowBreedDetails(source: dataStore!, destination: &destinationDS, breedId: breedId)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    
    // MARK: - Passing data
    private func passDataShowBreedDetails(source: ClassicCollectionDataStore, destination: inout BreedInfoDataStore, breedId: String) {
        guard let breed = source.breeds.first(where: { $0.id == breedId }) else { return }
        destination.breed = breed
    }
}
