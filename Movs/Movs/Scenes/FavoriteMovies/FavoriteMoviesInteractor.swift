//
//  FavoriteMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

protocol FavoriteMoviesBusinessLogic {
    func getMovies()
    func removeMovie(request: FavoriteMoviesModel.Request.Remove)
}

class FavoriteMoviesInteractor: FavoriteMoviesBusinessLogic {
    
    var presenter: FavoriteMoviesPresentationLogic!
    
    // w185 is a nice size for mobile app
    let imageBasePath = "http://image.tmdb.org/t/p/w185"
    
    func removeMovie(request: FavoriteMoviesModel.Request.Remove) {
        if !FavoriteMoviesWorker.shared.removeFavoriteMovie(id: request.movieId) {
            let errorResponse = FavoriteMoviesModel.Response.Error(title: "Erro", description: "Não foi possível remover o filme")
            presenter.presentError(response: errorResponse)
        }
    }
    
    func getMovies() {
        let movies: [MovieDetailed] = FavoriteMoviesWorker.shared.getFavoriteMovies()
        if !movies.isEmpty {
            let formattedMovies = getFormattedFavorites(movies: movies)
            let response = FavoriteMoviesModel.Response.Success(movies: formattedMovies)
            presenter.presentMovies(response: response)
        } else {
            let responseError = FavoriteMoviesModel.Response.Error(title: "Nenhum favorito", description: "Que tal iniciar a sua lista? Abra os detalhes de um filme e favorite-o.")
            presenter.presentError(response: responseError)
        }
    }
    
    private func getFormattedFavorites(movies: [MovieDetailed]) -> [FavoriteMoviesModel.FavoriteMovie] {
        var formattedMovies = [FavoriteMoviesModel.FavoriteMovie]()
        for element in movies {
            let id = element.id
            let title = element.title
            let overview = element.overview
            let posterPath = URL(string: element.posterPath)
            let releaseYear = String.getYearRelease(fullDate: element.releaseDate)

            let movie = FavoriteMoviesModel.FavoriteMovie(id: id, title: title, overview: overview, posterPath: posterPath!, year: releaseYear)
            formattedMovies.append(movie)
        }
        return formattedMovies
    }
    
    
}
