//
//  FavoritesPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol FavoritesView: AnyObject {
    func updateView(with movies: [Movie])
    func openMovieDetails(with movie: Movie)
    func openFiltersScreen()
}

class FavoritesPresenter {
    weak var view: FavoritesView?

    private let disposeBag = DisposeBag()
    private let moviesUseCase = MoviesUseCase()

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onMovieChanged(notification:)),
            name: NSNotification.Name.movie,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func onStart() {
        fetchFavoriteMovies()
    }

    func onMovieSelected(movie: Movie) {
        view?.openMovieDetails(with: movie)
    }

    func onMovieUnfavorited(movie: Movie) {
        movie.isFavorited = false
        moviesUseCase.unfavoriteMovie(movie)
            .subscribe(onCompleted: {
                self.notifyMovieChanged(movie)
            }, onError: { (error: Error) in
                // hehe
            })
            .disposed(by: disposeBag)
    }

    func onFilterSelected() {
        view?.openFiltersScreen()
    }

    // MARK: - Private methods

    private func fetchFavoriteMovies() {
        moviesUseCase.fetchFavoritedMovies()
            .subscribe(onSuccess: { (favoritedMovies: [Movie]) in
                self.view?.updateView(with: favoritedMovies)
            }, onError: { (error: Error) in
                print(error)
                // TODO
            })
            .disposed(by: disposeBag)
    }

    @objc private func onMovieChanged(notification: NSNotification) {
        fetchFavoriteMovies()
    }

    private func notifyMovieChanged(_ movie: Movie) {
        NotificationCenter.default.post(name: NSNotification.Name.movie, object: movie)
    }
}
