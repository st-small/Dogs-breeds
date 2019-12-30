//
//  BreedInfoPresenter.swift
//  Dogs breeds
//
//  Created by Stanly Shiyanovskiy on 29.12.2019.
//  Copyright (c) 2019 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol BreedInfoPresentationLogic {
    func presentData(response: BreedInfo.Model.Response)
}

public class BreedInfoPresenter: BreedInfoPresentationLogic {
    
    public weak var viewController: BreedInfoDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: BreedInfo.Model.Response) {
        switch response {
        case .presentInfo(let breed):
            let model = prepareModel(breed)
            viewController?.displaySomething(viewModel: .displayInfo(model))
        }
    }
    
    private func prepareModel(_ breed: BreedItemModel) -> BreedInfoViewModel {
        let name = breed.breeds.first?.name ?? ""
        let rows = prepareBreedRows(breed.breeds.first)
        return BreedInfoViewModel(imageUrl: breed.url,
                                  name: name,
                                  rows: rows)
    }
    
    private func prepareBreedRows(_ breed: BreedItem?) -> [BreedInfoRow] {
        guard let breed = breed else { return [] }
        
        var elements = [BreedInfoRow]()
        
        let nameRow = BreedInfoRow()
        nameRow.setup(title: "Name:", text: breed.name)
        elements.append(nameRow)
        
        if let breedFor = breed.bredFor {
            let breedForRow = BreedInfoRow()
            breedForRow.setup(title: "Breed for:", text: breedFor)
            elements.append(breedForRow)
        }
        
        if let breeedGroup = breed.breedGroup, !breeedGroup.isEmpty {
            let breeedGroupRow = BreedInfoRow()
            breeedGroupRow.setup(title: "Breed group:", text: breeedGroup)
            elements.append(breeedGroupRow)
        }
        
        let lifeSpanRow = BreedInfoRow()
        lifeSpanRow.setup(title: "Life span:", text: breed.lifeSpan)
        elements.append(lifeSpanRow)
        
        return elements
    }
}



