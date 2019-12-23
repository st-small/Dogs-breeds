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
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

public protocol BreedsListDataPassing {
    var dataStore: BreedsListDataStore? { get }
}

public class BreedsListRouter: NSObject, BreedsListRoutingLogic, BreedsListDataPassing {
    public weak var viewController: BreedsListViewController?
    public var dataStore: BreedsListDataStore?
    
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
    //func passDataToSomewhere(source: BreedsListDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
