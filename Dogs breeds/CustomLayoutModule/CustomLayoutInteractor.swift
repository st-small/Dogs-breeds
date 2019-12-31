//
//  CustomLayoutInteractor.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 31.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol CustomLayoutBusinessLogic {
    func makeRequest(request: CustomLayout.Model.Request)
}

public protocol CustomLayoutDataStore {
    var breeds: [BreedItemModel] { get }
}

public class CustomLayoutInteractor: CustomLayoutBusinessLogic, CustomLayoutDataStore {
    
    // MARK: - Data
    public var breeds = [BreedItemModel]()
    
    // MARK: - Services
    public var presenter: CustomLayoutPresentationLogic?
    
    // MARK: - Main logic
    public func makeRequest(request: CustomLayout.Model.Request) {
        switch request {
        case .breeds:
            loadBreeds()
        }
    }
    
    private func loadBreeds() {
        guard let filepath = Bundle.main.path(forResource: "breeds", ofType: "json") else { return }
        let fileUrl = URL(fileURLWithPath: filepath)
        guard let data = try? Data(contentsOf: fileUrl, options: .mappedIfSafe) else { return }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let breedsDecoded = try? decoder.decode([BreedItemModel].self, from: data) else { return }
        breeds = breedsDecoded
        presenter?.presentData(response: .presentBreeds(breedsDecoded))
    }
}
