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
    func updateWith(movies: [Movie])
}

class MoviesPresenter {

    weak var view: MoviesView?

    private let moviesUseCase = MoviesUseCase()
    private let disposeBag = DisposeBag()

    func onStart() {
        moviesUseCase.fetchNextPopularMovies()
            .subscribe(onSuccess: { (movies: [Movie]) in
                self.view?.updateWith(movies: movies)
            }, onError: { (error: Error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func onMovieSelected() {
        view?.openMovieDetails()
    }
}
