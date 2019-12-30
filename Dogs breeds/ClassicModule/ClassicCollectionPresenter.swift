//
//  ClassicCollectionPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 30.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol ClassicCollectionPresentationLogic {
    func presentData(response: ClassicCollection.Model.Response)
}

public class ClassicCollectionPresenter: ClassicCollectionPresentationLogic {
    public weak var viewController: ClassicCollectionDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: ClassicCollection.Model.Response) {
        switch response {
        case .presentBreeds(let items):
            viewController?.displayData(viewModel: .displayBreeds(items))
        }
    }
}
