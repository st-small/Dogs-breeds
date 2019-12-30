//
//  MainPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MainPresentationLogic {
    func presentData(response: Main.Model.Response)
}

public class MainPresenter: MainPresentationLogic {
    
    public weak var viewController: MainDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: Main.Model.Response) {
        switch response {
        case .presentMainData(let values):
            viewController?.displayData(viewModel: .displayMainData(values))
        }
    }
}
