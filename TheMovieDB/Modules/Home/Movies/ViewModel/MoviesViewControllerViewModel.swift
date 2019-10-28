//
//  MoviesViewControllerViewModel.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

class MoviesViewControllerViewModel {
    var delegate: MoviesViewControllerProtocol!
    var dao: SQLiteManager!
    var favoritedMovies: [MovieResponse]?
    var isRequesting = false
    
    init(delegate: MoviesViewControllerProtocol) {
        self.delegate = delegate
        dao = SQLiteManager()
    }
    
    func updateFavoritedMovies(_ movies: MovieListResponse) {
        delegate.setMoviesList(movies: filterFavoritedMovies(movies))
    }
    
    private func filterFavoritedMovies(_ movies: MovieListResponse) -> MovieListResponse {
        if movies.results != nil {
            favoritedMovies = dao.selectFavoritedMovies()
            var moviesTemp = movies
            for i in 0 ..< moviesTemp.results!.count {
                moviesTemp.results![i].isFavorited = false
            }
            for favoritedMovie in favoritedMovies! {
                for i in 0 ..< moviesTemp.results!.count {
                    if moviesTemp.results![i].id == favoritedMovie.id {
                        moviesTemp.results![i].isFavorited = true
                        break
                    }
                }
            }
            delegate.changeScreenStatus(type: .normal)
            return moviesTemp
        } else {
            delegate.changeScreenStatus(type: .empty)
            return movies
        }
    }
    
    // MARK: - Request
    func requestPopularMovies(page: Int, showLoading: Bool) {
        if !isRequesting {
            isRequesting = true
            if showLoading {
                delegate.changeScreenStatus(type: .loading)
            }
            func onError(message: String) {
                delegate.changeScreenStatus(type: .error)
                delegate.setError(message: message)
                isRequesting = false
            }
            func onSuccess(movies: MovieListResponse) {
                delegate.appendMoviesList(movies: filterFavoritedMovies(movies))
                isRequesting = false
            }
            API.MovieService().getMoviePopular(page: page, onError: onError(message:), onSuccess: onSuccess(movies:))
        }
    }
}
