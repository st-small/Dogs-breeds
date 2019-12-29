//
//  BreedInfoViewController.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import SDWebImage
import UIKit

public protocol BreedInfoDisplayLogic: class {
    func displaySomething(viewModel: BreedInfo.Model.ViewModel)
}

public class BreedInfoViewController: UIViewController {
    
    // MARK: - UI elements
    private var breedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return imageView
    }()
    
    private var infoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9294117647, blue: 0.4980392157, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return view
    }()
    
    private var infoDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = "Info:".prepareBoldAttributedString()
        label.textAlignment = .center
        return label
    }()
    
    private var breedRowsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    public var router: (NSObjectProtocol & BreedInfoRoutingLogic & BreedInfoDataPassing)?
    private var interactor: BreedInfoBusinessLogic?
    
    
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
        let interactor = BreedInfoInteractor()
        let presenter = BreedInfoPresenter()
        let router = BreedInfoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        userInterfaceSetup()
    }
    
    private func userInterfaceSetup() {
        view.backgroundColor = #colorLiteral(red: 0.4, green: 0.6862745098, blue: 1, alpha: 1)
    }
    
    private func configureNavigationBar(_ title: String) {
        navigationItem.title = title
    }
    
    private func configureImageView(_ url: String) {
        let height = UIScreen.main.bounds.width - 32
        view.addSubview(breedImage)
        breedImage.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(height)
        }
        
        breedImage.layer.cornerRadius = 10
        breedImage.clipsToBounds = true
        breedImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        breedImage.sd_setImage(with: URL(string: url),
                               placeholderImage: nil,
                               completed: nil)
    }
    
    private func configureInfoContainer() {
        view.addSubview(infoContainer)
        infoContainer.snp.remakeConstraints { make in
            make.top.equalTo(breedImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        infoContainer.layer.cornerRadius = 10
        
        configureInfoDescription()
    }
    
    private func configureInfoDescription() {
        infoContainer.addSubview(infoDescription)
        infoDescription.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
    }
    
    private func configureBreedRowsStack(_ views: [BreedInfoRow]) {
        infoContainer.addSubview(breedRowsStack)
        breedRowsStack.snp.remakeConstraints { make in
            make.top.equalTo(infoDescription.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        _ = views.map({ breedRowsStack.addArrangedSubview($0) })
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.makeRequest(request: .getInfo)
    }
    
    // MARK: - Main logic
    
}

extension BreedInfoViewController: BreedInfoDisplayLogic {
    public func displaySomething(viewModel: BreedInfo.Model.ViewModel) {
        switch viewModel {
        case .displayInfo(let model):
            configureNavigationBar(model.name)
            configureImageView(model.imageUrl)
            configureInfoContainer()
            configureBreedRowsStack(model.rows)
        }
    }
}
