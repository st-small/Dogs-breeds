//
//  MosaicLayoutRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol MosaicLayoutRoutingLogic {
    func routeToInfo(_ breedId: String)
}

public protocol MosaicLayoutDataPassing {
    var dataStore: MosaicLayoutDataStore? { get }
}

public class MosaicLayoutRouter: NSObject, MosaicLayoutRoutingLogic, MosaicLayoutDataPassing {
    public weak var viewController: MosaicLayoutViewController?
    public var dataStore: MosaicLayoutDataStore?
    
    // MARK: - Routing
    public func routeToInfo(_ breedId: String) {
         let detail = BreedInfoViewController()
         var destinationDS = detail.router!.dataStore!
         passDataShowBreedDetails(source: dataStore!, destination: &destinationDS, breedId: breedId)
         viewController?.navigationController?.pushViewController(detail, animated: true)
     }
    
    // MARK: - Passing data
    private func passDataShowBreedDetails(source: MosaicLayoutDataStore, destination: inout BreedInfoDataStore, breedId: String) {
        guard let breed = source.breeds.first(where: { $0.id == breedId }) else { return }
        destination.breed = breed
    }
}
