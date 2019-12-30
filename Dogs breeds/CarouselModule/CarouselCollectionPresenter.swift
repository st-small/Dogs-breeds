//
//  CarouselCollectionPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol CarouselCollectionPresentationLogic {
    func presentData(response: CarouselCollection.Model.Response)
}

public class CarouselCollectionPresenter: CarouselCollectionPresentationLogic {
    
    public weak var viewController: CarouselCollectionDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: CarouselCollection.Model.Response) {
        switch response {
        case .presentBreeds(let items):
            viewController?.displayData(viewModel: .displayBreeds(items))
        }
    }
}
