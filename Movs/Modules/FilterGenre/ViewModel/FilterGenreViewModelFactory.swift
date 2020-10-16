//
//  FilterGenreViewModelFactory.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import Foundation

class FilterGenreViewModelFactory {
    
    func create() -> FilterGenreViewModel {
        return FilterGenreViewModel(
            service: MoviesListService(),
            viewState: ViewState<GenresDTO, HTTPError>()
        )
    }
}
