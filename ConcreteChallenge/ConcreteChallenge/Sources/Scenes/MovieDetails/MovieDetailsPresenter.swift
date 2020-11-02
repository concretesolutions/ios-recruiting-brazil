//
//  MovieDetailsPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsPresentationLogic: AnyObject {
    func onSaveMovieSuccessful()
    func onSaveMovieFailure()
    func onDeleteMovieSuccessful()
    func onDeleteMovieFailure()
}

final class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    weak var viewController: MovieDetailsDisplayLogic?

    // MARK: - MovieDetailsPresentationLogic conforms

    func onSaveMovieSuccessful() {
        viewController?.displayFavoriteIcon()
    }

    func onSaveMovieFailure() {
        viewController?.displayUnfavoriteIcon()
    }

    func onDeleteMovieSuccessful() {
        viewController?.displayUnfavoriteIcon()
    }

    func onDeleteMovieFailure() {
        viewController?.displayFavoriteIcon()
    }
}
