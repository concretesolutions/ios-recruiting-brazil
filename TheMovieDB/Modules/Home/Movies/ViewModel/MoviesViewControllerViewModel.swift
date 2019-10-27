//
//  MoviesViewControllerViewModel.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

class MoviesViewControllerViewModel {
    var delegate: MoviesViewControllerProtocol!
    
    init(delegate: MoviesViewControllerProtocol) {
        self.delegate = delegate
    }
    
    func requestPopularMovies(page: Int) {
        delegate.changeScreenStatus(type: .loading)
        func onError(message: String) {
            delegate.changeScreenStatus(type: .error)
            delegate.setError(message: message)
        }
        func onSuccess(movies: MovieListResponse) {
            delegate.setMoviesList(movies: movies)
            delegate.changeScreenStatus(type: .normal)
        }
        API.MovieService().getMoviePopular(page: page, onError: onError(message:), onSuccess: onSuccess(movies:))
    }
}
