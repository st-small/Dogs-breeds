//
//  MosaicLayoutViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MosaicLayoutDisplayLogic: class {
    func displayData(viewModel: MosaicLayout.Model.ViewModel)
}

public class MosaicLayoutViewController: UIViewController {
    
    // MARK: - UI elements
    private var breedsCollection = MosaicLayoutCollectionView()
    
    public var router: (NSObjectProtocol & MosaicLayoutRoutingLogic & MosaicLayoutDataPassing)?
    private var interactor: MosaicLayoutBusinessLogic?
    
    
    // MARK: - Object lifecycle
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MosaicLayoutInteractor()
        let presenter = MosaicLayoutPresenter()
        let router = MosaicLayoutRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        userInterfaceSetup()
    }
    
    private func userInterfaceSetup() {
        view.backgroundColor = #colorLiteral(red: 0.7129858136, green: 0.8651095629, blue: 0.9885597825, alpha: 1)
        configureBreedsCollection()
    }
    
    private func configureBreedsCollection() {
        view.addSubview(breedsCollection)
        breedsCollection.snp.remakeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        breedsCollection.cellDelegate = self
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.makeRequest(request: .breeds)
    }
    
    // MARK: - Main logic
}

extension MosaicLayoutViewController: MosaicLayoutDisplayLogic {
    public func displayData(viewModel: MosaicLayout.Model.ViewModel) {
        switch viewModel {
        case .displayBreeds(let items):
            breedsCollection.set(breeds: items)
            breedsCollection.reloadData()
        }
    }
}

extension MosaicLayoutViewController: MosaicLayoutCollectionDelegate {
    public func breedSelected(_ breedId: String) {
        router?.routeToInfo(breedId)
    }
}
