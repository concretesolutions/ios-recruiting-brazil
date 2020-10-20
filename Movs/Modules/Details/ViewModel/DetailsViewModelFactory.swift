//
//  DetailsViewModelFactory.swift
//  Movs
//
//  Created by Joao Lucas on 14/10/20.
//

import Foundation

class DetailsViewModelFactory {
    
    func create() -> DetailsViewModel {
        return DetailsViewModel(
            useCase: MoviesListUseCase(),
            service: DetailsService(),
            viewState: ViewState<ImagesDTO, HTTPError>()
        )
    }
}
