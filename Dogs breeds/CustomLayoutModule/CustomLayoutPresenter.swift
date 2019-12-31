//
//  CustomLayoutPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol CustomLayoutPresentationLogic {
    func presentData(response: CustomLayout.Model.Response)
}

public class CustomLayoutPresenter: CustomLayoutPresentationLogic {
    
    public weak var viewController: CustomLayoutDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: CustomLayout.Model.Response) {
        switch response {
        case .presentBreeds(let items):
            viewController?.displayData(viewModel: .displayBreeds(items))
        }
    }
}
