//
//  StretchyHeaderPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol StretchyHeaderPresentationLogic {
    func presentData(response: StretchyHeader.Model.Response)
}

public class StretchyHeaderPresenter: StretchyHeaderPresentationLogic {
    
    public weak var viewController: StretchyHeaderDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: StretchyHeader.Model.Response) {
        switch response {
        case .presentBreeds(let items):
            viewController?.displayData(viewModel: .displayBreeds(items))
        }
    }
}
