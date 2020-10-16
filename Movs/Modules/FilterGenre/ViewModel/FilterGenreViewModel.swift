//
//  FilterGenreViewModel.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import Foundation

class FilterGenreViewModel {
    
    let service: MoviesListService
    
    var viewState: ViewState<GenresDTO, HTTPError>
    
    init(service: MoviesListService, viewState: ViewState<GenresDTO, HTTPError>) {
        self.service = service
        self.viewState = viewState
    }
    
    func fetchListGenres() -> ViewState<GenresDTO, HTTPError> {
        viewState.fetchSource {
            MoviesListService().getGenres { result in
                switch result {
                case .success(let genres):
                    self.viewState.success(data: genres)
                case .failure(let error):
                    self.viewState.error(error: error)
                }
            }
        }
        
        return viewState
    }
}
