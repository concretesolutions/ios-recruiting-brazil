//
//  FiltersPresenter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersPresentationLogic {
    func present(response: Filters.Response)
}

class FiltersPresenter: FiltersPresentationLogic {
    weak var viewController: FiltersDisplayLogic!
    
    func present(response: Filters.Response) {
        let viewModel = Filters.ViewModel(movies: response.movies)
        viewController.applyFilter(viewModel: viewModel)
    }
}
