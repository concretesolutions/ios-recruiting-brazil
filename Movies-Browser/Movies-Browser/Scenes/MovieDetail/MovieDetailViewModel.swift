//
//  MovieDetailViewModel.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

struct MovieDetailState {
    // MARK: Data
    var posterImageURL: String
    var titleText: String
    var releaseDateText: String
    var genreListText: String
    var descriptionText: String
    var isFavorite: Bool
}

final class MovieDetailViewModel {
    let database = Database()
    private var movie: Movie {
        didSet {
            movieValueDidChange()
        }
    }
    
    var state: MovieDetailState = MovieDetailState(posterImageURL: "", titleText: "", releaseDateText: "", genreListText: "", descriptionText: "", isFavorite: false) {
        didSet {
            callback?(state)
        }
    }
    
    var callback: ((MovieDetailState) -> ())? {
        didSet {
            callback?(state)
        }
    }
    
    public init(movie: Movie, callback: ((MovieDetailState) -> ())?) {
        self.callback = callback
        self.movie = movie
        self.movieValueDidChange()
    }
}

// MARK: - Inputs -
extension MovieDetailViewModel {
    func favoriteButtonWasTapped(){
        state.isFavorite.toggle()
        updateFavoriteDatabaseState()
    }
    
    func movieValueDidChange(){
        state.posterImageURL = AppConstants.API.imageBaseUrl + movie.posterPath
        state.titleText = movie.title
        state.descriptionText = movie.overview
        state.releaseDateText = movie.releaseDate.year
        state.isFavorite = database.isFavorited(id: movie.id)
        state.genreListText = database.getGenresListString(ids: movie.genreIds)
    }
}

// MARK: - Database -
extension MovieDetailViewModel {
    func updateFavoriteDatabaseState(){
        if state.isFavorite {
            database.addNewFavorite(movie: movie)
        } else {
            database.deleteFavorite(id: movie.id)
        }
    }
}
