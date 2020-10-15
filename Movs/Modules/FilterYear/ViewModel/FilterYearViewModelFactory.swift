//
//  FilterYearViewModelFactory.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import Foundation

class FilterYearViewModelFactory {
    
    func create() -> FilterYearViewModel {
        return FilterYearViewModel(
            service: MoviesListService(),
            viewState: ViewState<MoviesDTO, HTTPError>()
        )
    }
}
