//
//  MoviesListViewModelFactory.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

class MoviesListViewModelFactory {
    
    func create() -> MoviesListViewModel {
        return MoviesListViewModel(
            service: MoviesListService(),
            viewState: ViewState<MoviesDTO, HTTPError>()
        )
    }
}
