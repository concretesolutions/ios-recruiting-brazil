//
//  FilterYearViewModel.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import Foundation

class FilterYearViewModel {
    
    var service: MoviesListService
    
    var viewState: ViewState<MoviesDTO, HTTPError>
    
    init(service: MoviesListService, viewState: ViewState<MoviesDTO, HTTPError>) {
        self.service = service
        self.viewState = viewState
    }
    
    func fetchYearsList() -> ViewState<MoviesDTO, HTTPError> {
        self.service.getMoviesList { [weak self] result in
            switch result {
            case .success(let movies):
                self?.viewState.success(data: movies)
            case .failure(let message):
                self?.viewState.error(error: message)
            }
        }
        
        return viewState
    }
    
}
