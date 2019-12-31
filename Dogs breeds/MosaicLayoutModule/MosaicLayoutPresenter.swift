//
//  MosaicLayoutPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol MosaicLayoutPresentationLogic {
    func presentData(response: MosaicLayout.Model.Response)
}

public class MosaicLayoutPresenter: MosaicLayoutPresentationLogic {
    
    public weak var viewController: MosaicLayoutDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: MosaicLayout.Model.Response) {
        switch response {
        case .presentBreeds(let items):
            viewController?.displayData(viewModel: .displayBreeds(items))
        }
    }
}
