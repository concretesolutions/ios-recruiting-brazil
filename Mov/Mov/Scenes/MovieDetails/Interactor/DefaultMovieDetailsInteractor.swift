//
//  DefaultMovieDetailsInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


final class DefaultMovieDetailsInteractor {
    
    let persistence: FavoritesPersistence
    let presenter: MovieDetailsPresenter
    var favorites = Set<Movie>()
    
    init(presenter: MovieDetailsPresenter, persistence: FavoritesPersistence) {
        self.presenter = presenter
        self.persistence = persistence
    }
    
    func movieDetailsUnit(from movie: Movie) -> MovieDetailsUnit {
        let genres = Genre.genres(forIds: movie.genreIds).map { $0.name }
        let isFavorite = self.favorites.contains(movie)
        return MovieDetailsUnit(fromMovie: movie, isFavorite: isFavorite, genres: genres)
    }
}

extension DefaultMovieDetailsInteractor: MovieDetaisInteractor {
    func getDetails(of movie: Movie) {
        do {
            self.favorites = try self.persistence.fetchFavorites()
        } catch {/*present db error*/}
        
        self.presenter.presentDetails(of: movieDetailsUnit(from: movie))
    }
    
    func toggleFavorite(_ movie: Movie) {
        do {
            try self.persistence.toggleFavorite(movie: movie)
            self.getDetails(of: movie)
        } catch {/*present db error*/}
    }
}
