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
}

class FavoritesPresenter {
    weak var view: FavoritesView?

    private let disposeBag = DisposeBag()
    private let moviesUseCase = MoviesUseCase()

    func onStart() {
        moviesUseCase.fetchFavoritedMovies()
            .subscribe(onSuccess: { (favoritedMovies: [Movie]) in
                self.view?.updateView(with: favoritedMovies)
            }, onError: { (error: Error) in
                print(error)
                // TODO
            })
            .disposed(by: disposeBag)
    }

    func onMovieSelected(movie: Movie) {
        view?.openMovieDetails(with: movie)
    }
}
