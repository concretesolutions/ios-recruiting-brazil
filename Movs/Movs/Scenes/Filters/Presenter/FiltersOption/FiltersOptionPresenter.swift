//
//  FiltersOptionPresenter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersOptionPresentationLogic {
    func presentFilters(response: Filters.Option.Response)
}

class FiltersOptionPresenter: FiltersOptionPresentationLogic {
    weak var viewController: FiltersOptionDisplayLogic!
    
    func presentFilters(response: Filters.Option.Response) {
        let viewModel = Filters.Option.ViewModel(filters: response.filters)
        viewController.displayFilters(viewModel: viewModel)
    }
}
