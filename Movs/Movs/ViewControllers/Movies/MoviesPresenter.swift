//
//  MoviesPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol MoviesView: AnyObject {
    func openMovieDetails(with movie: Movie)
    func updateWith(movies: [Movie])
    func update(with movie: Movie)
    func setLoading(to loading: Bool)
}

class MoviesPresenter {

    weak var view: MoviesView?

    private let moviesUseCase = MoviesUseCase()
    private let disposeBag = DisposeBag()

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
        view?.setLoading(to: true)
        moviesUseCase.fetchNextPopularMovies()
            .subscribe(onSuccess: { (movies: [Movie]) in
                self.view?.setLoading(to: false)
                self.view?.updateWith(movies: movies)
            }, onError: { (error: Error) in
                self.view?.setLoading(to: false)
                // TODO
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func onMovieSelected(movie: Movie) {
        view?.openMovieDetails(with: movie)
    }

    @objc private func onMovieChanged(notification: NSNotification) {
        if let changedMovie = notification.object as? Movie {
            view?.update(with: changedMovie)
        }
    }
}
