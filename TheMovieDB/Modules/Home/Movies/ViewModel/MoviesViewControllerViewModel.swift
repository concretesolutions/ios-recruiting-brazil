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
    
    init(delegate: MoviesViewControllerProtocol) {
        self.delegate = delegate
        dao = SQLiteManager()
    }
    
    func filterFavoritedMovies(_ movies: MovieListResponse) {
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
            delegate.setMoviesList(movies: moviesTemp)
            delegate.changeScreenStatus(type: .normal)
        } else {
            delegate.changeScreenStatus(type: .empty)
        }
    }
    
    // MARK: - Request
    func requestPopularMovies(page: Int) {
        delegate.changeScreenStatus(type: .loading)
        func onError(message: String) {
            delegate.changeScreenStatus(type: .error)
            delegate.setError(message: message)
        }
        func onSuccess(movies: MovieListResponse) {
            filterFavoritedMovies(movies)
        }
        API.MovieService().getMoviePopular(page: page, onError: onError(message:), onSuccess: onSuccess(movies:))
    }
}
