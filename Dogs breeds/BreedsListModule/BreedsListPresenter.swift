//
//  BreedsListPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 23.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol BreedsListPresentationLogic {
    func presentData(response: BreedsList.Model.Response)
}

public class BreedsListPresenter: BreedsListPresentationLogic {
    
    public weak var viewController: BreedsListDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: BreedsList.Model.Response) {
        switch response {
        case .presentBreeds(let items):
            viewController?.displayData(viewModel: .displayBreeds(items))
        }
    }
}
