//
//  BreedsListViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 23.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol BreedsListDisplayLogic: class {
    func displayData(viewModel: BreedsList.Model.ViewModel)
}

public class BreedsListViewController: UIViewController {
    
    // MARK: - UI elements
    public var router: (NSObjectProtocol & BreedsListRoutingLogic & BreedsListDataPassing)?
    private var interactor: BreedsListBusinessLogic?
    
    
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
        let interactor = BreedsListInteractor()
        let presenter = BreedsListPresenter()
        let router = BreedsListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        userInterfaceSetup()
    }
    
    private func userInterfaceSetup() {
        view.backgroundColor = .white
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.makeRequest(request: .breeds)
    }
    
    // MARK: - Main logic
}


extension BreedsListViewController: BreedsListDisplayLogic {
    public func displayData(viewModel: BreedsList.Model.ViewModel) {
        switch viewModel {
        case .displayBreeds(let items):
            break
        }
    }
}
