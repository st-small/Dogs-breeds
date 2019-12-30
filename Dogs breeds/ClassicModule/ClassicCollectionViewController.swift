//
//  ClassicCollectionViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol ClassicCollectionDisplayLogic: class {
    func displayData(viewModel: ClassicCollection.Model.ViewModel)
}

public class ClassicCollectionViewController: UIViewController {
    
    // MARK: - UI elements
    private var breedsCollection = ClassicCollectionView()
    
    public var router: (NSObjectProtocol & ClassicCollectionRoutingLogic & ClassicCollectionDataPassing)?
    private var interactor: ClassicCollectionBusinessLogic?
    
    
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
        let interactor = ClassicCollectionInteractor()
        let presenter = ClassicCollectionPresenter()
        let router = ClassicCollectionRouter()
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
        
        navigationItem.title = "Breeds"
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

extension ClassicCollectionViewController: ClassicCollectionDisplayLogic {
    public func displayData(viewModel: ClassicCollection.Model.ViewModel) {
        switch viewModel {
        case .displayBreeds(let items):
            breedsCollection.set(breeds: items)
            breedsCollection.reloadData()
        }
    }
}

extension ClassicCollectionViewController: ClassicCollectionDelegate {
    public func breedSelected(_ breedId: String) {
        router?.routeToInfo(breedId)
    }
}
