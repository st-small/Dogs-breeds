//
//  StretchyHeaderViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol StretchyHeaderDisplayLogic: class {
    func displayData(viewModel: StretchyHeader.Model.ViewModel)
}

public class StretchyHeaderViewController: UIViewController {
    
    // MARK: - UI elements
    private var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var breedsCollection = StretchyHeaderCollectionView()
    
    public var router: (NSObjectProtocol & StretchyHeaderRoutingLogic & StretchyHeaderDataPassing)?
    private var interactor: StretchyHeaderBusinessLogic?
    
    
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
        let interactor = StretchyHeaderInteractor()
        let presenter = StretchyHeaderPresenter()
        let router = StretchyHeaderRouter()
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
        configureBackButton()
    }
    
    private func configureBreedsCollection() {
        view.addSubview(breedsCollection)
        breedsCollection.snp.remakeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        breedsCollection.cellDelegate = self
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        let image = UIImage(named: "back")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.addSubview(imageView)
        imageView.snp.remakeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        backButton.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(44)
        }
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.makeRequest(request: .breeds)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Main logic
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension StretchyHeaderViewController: StretchyHeaderDisplayLogic {
    public func displayData(viewModel: StretchyHeader.Model.ViewModel) {
        switch viewModel {
        case .displayBreeds(let items):
            breedsCollection.set(breeds: items)
            breedsCollection.reloadData()
        }
    }
}

extension StretchyHeaderViewController: StretchyHeaderCollectionViewDelegate {
    public func breedSelected(_ breedId: String) {
        router?.routeToInfo(breedId)
    }
}
