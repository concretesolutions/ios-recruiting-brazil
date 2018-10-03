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
    func openMovieDetails()
}

class MoviesPresenter {

    weak var view: MoviesView?

    private let moviesUseCase = PopularMoviesUseCase()
    private let disposeBag = DisposeBag()

    func onStart() {
        moviesUseCase.fetchNextPopularMovies()
            .subscribe(onSuccess: { (movies: [Movie]) in
                print(movies.count)
                // TODO
            }, onError: { (error: Error) in
                // TODO
            })
            .disposed(by: disposeBag)
    }

    func onMovieSelected() {
        view?.openMovieDetails()
    }
}
