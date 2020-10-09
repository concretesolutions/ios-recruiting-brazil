//
//  MoviesListViewModel.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

class MoviesListViewModel {
    
    let service: MoviesListService
    
    var viewState: ViewState<MoviesDTO, HTTPError>
    
    init(service: MoviesListService, viewState: ViewState<MoviesDTO, HTTPError>) {
        self.service = service
        self.viewState = viewState
    }
    
    func fetchMoviesList() -> ViewState<MoviesDTO, HTTPError> {
        viewState.fetchSource {
            self.service.getMoviesList { [weak self] result in
                switch result {
                case .success(let movies):
                    self?.viewState.success(data: movies)
                case .failure(let message):
                    self?.viewState.error(error: message)
                }
            }
        }
        
        return viewState
    }
}
