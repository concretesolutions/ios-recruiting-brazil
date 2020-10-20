//
//  DetailsViewModel.swift
//  Movs
//
//  Created by Joao Lucas on 14/10/20.
//

import Foundation
import RealmSwift

class DetailsViewModel: DataLifeViewModel {
    
    var useCase: MoviesListUseCase
    
    var successAdding = DataLife<String>()
    
    var successRemoving = DataLife<String>()
    
    var service: DetailsService
    
    var viewState: ViewState<ImagesDTO, HTTPError>
    
    init(useCase: MoviesListUseCase, service: DetailsService, viewState: ViewState<ImagesDTO, HTTPError>) {
        self.useCase = useCase
        self.service = service
        self.viewState = viewState
    }
    
    func fetchCast(idMovie: Int) -> ViewState<ImagesDTO, HTTPError> {
        viewState.fetchSource {
            self.service.getImages(idMovie: idMovie) { result in
                switch result {
                case .success(let cast):
                    self.viewState.success(data: cast)
                case .failure(let message):
                    self.viewState.error(error: message)
                }
            }
        }
        
        return viewState
    }
    
    func loadAddToFavorite(realm: Realm, movie: ResultMoviesDTO) {
        useCase.addToFavorites(realm: realm, movie: movie) {
            self.successAdding.value = "Success in adding to favorites"
        }
    }
    
    func loadRemoveFavorite(realm: Realm, movie: ResultMoviesDTO) {
        useCase.removeFavorites(realm: realm, movie: movie) {
            self.successRemoving.value = "Success when removing from favorites"
        }
    }
    
}
