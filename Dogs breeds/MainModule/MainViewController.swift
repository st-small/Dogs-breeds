//
//  MainViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MainDisplayLogic: class {
    func displayData(viewModel: Main.Model.ViewModel)
}

public class MainViewController: UIViewController {
    
    // MARK: - UI elements
    private var collectionsTypesTable = UITableView()
    
    public var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    private var interactor: MainBusinessLogic?
    
    // MARK: - Data
    private var collectionsTypes = [String]()
    
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
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
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
        
        navigationItem.title = "Collection view types"
        configureCollectionsTypesTable()
    }
    
    private func configureCollectionsTypesTable() {
        view.addSubview(collectionsTypesTable)
        collectionsTypesTable.translatesAutoresizingMaskIntoConstraints = false
        collectionsTypesTable.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        collectionsTypesTable.delegate = self
        collectionsTypesTable.dataSource = self
        
        collectionsTypesTable.tableFooterView = UIView()
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.makeRequest(request: .getMainData)
    }
    
    // MARK: - Main logic

}

extension MainViewController: MainDisplayLogic {
    public func displayData(viewModel: Main.Model.ViewModel) {
        switch viewModel {
        case .displayMainData(let values):
            collectionsTypes = values
            collectionsTypesTable.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToShowCollectionView(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension MainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionsTypes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = collectionsTypes[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
