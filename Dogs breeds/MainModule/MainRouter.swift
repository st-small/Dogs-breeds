//
//  MainRouter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol MainRoutingLogic {
    func routeToShowCollectionView(_ index: Int)
}

public protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

public class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    public weak var viewController: MainViewController?
    public var dataStore: MainDataStore?
    
    // MARK: - Routing
    public func routeToShowCollectionView(_ index: Int) {
        switch index {
        case 0:
            showClassicCollectionView()
        case 1:
            showCarouselCollectionView()
        case 2:
            showStretchyHeaderCollectionView()
        case 3:
            showCustomLayoutCollectionView()
        default: break
        }
    }
    
    private func showClassicCollectionView() {
        let vc = ClassicCollectionViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showCarouselCollectionView() {
        let vc = CarouselCollectionViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showStretchyHeaderCollectionView() {
        let vc = StretchyHeaderViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showCustomLayoutCollectionView() {
        let vc = CustomLayoutViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
