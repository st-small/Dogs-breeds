//
//  CustomLayoutViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol CustomLayoutDisplayLogic: class {
    func displayData(viewModel: CustomLayout.Model.ViewModel)
}

public class CustomLayoutViewController: UIViewController {
    
    // MARK: - UI elements
    private var breedsCollection = CustomLayoutCollectionView()
    
    public var router: (NSObjectProtocol & CustomLayoutRoutingLogic & CustomLayoutDataPassing)?
    private var interactor: CustomLayoutBusinessLogic?
    
    
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
        let interactor = CustomLayoutInteractor()
        let presenter = CustomLayoutPresenter()
        let router = CustomLayoutRouter()
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

extension CustomLayoutViewController: CustomLayoutDisplayLogic {
    public func displayData(viewModel: CustomLayout.Model.ViewModel) {
        switch viewModel {
        case .displayBreeds(let items):
            breedsCollection.set(breeds: items)
            breedsCollection.reloadData()
        }
    }
}

extension CustomLayoutViewController: CustomLayoutCollectionDelegate {
    public func breedSelected(_ breedId: String) {
        router?.routeToInfo(breedId)
    }
}
