//
//  MoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesPresenter: MoviesPresentationLogic {
    private let moviesDisplayLogic: MoviesDisplayLogic

    // MARK: - Initializers

    init(moviesDisplayLogic: MoviesDisplayLogic) {
        self.moviesDisplayLogic = moviesDisplayLogic
    }

    // MARK: - MoviesPresentationLogic conforms

    func presentMoviesItems(response: MoviesModels.MoviesItems.Response) {
        let viewModel = MoviesModels.MoviesItems.ViewModel()
        moviesDisplayLogic.displayMoviesItems(viewModel: viewModel)
    }
}
