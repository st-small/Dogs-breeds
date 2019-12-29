//
//  BreedInfoRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol BreedInfoRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

public protocol BreedInfoDataPassing {
    var dataStore: BreedInfoDataStore? { get }
}

public class BreedInfoRouter: NSObject, BreedInfoRoutingLogic, BreedInfoDataPassing {
    public weak var viewController: BreedInfoViewController?
    public var dataStore: BreedInfoDataStore?
    
    // MARK: - Routing
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: - Passing data
    //func passDataToSomewhere(source: BreedInfoDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
