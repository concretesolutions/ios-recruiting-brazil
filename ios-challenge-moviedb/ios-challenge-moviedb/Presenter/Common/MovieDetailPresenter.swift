//
//  MovieDetailPresenter.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 24/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieDetailViewDelegate {
}

class MovieDetailPresenter {
    
    var movieView: MovieDetailViewDelegate?
    var isLocalData: Bool
    
    init(isLocalData: Bool) {
        self.isLocalData = isLocalData
    }
    
    func getMovieImageURL(width: Int, path: String) -> URL? {
        let imageURL = ImagesEndpoint.movieImage(width: width, path: path).imageUrl
        return imageURL
    }
    
    func getGenres(ids: [Int], completion: @escaping ([String]?) -> Void) {
        var movieGenresString: [String] = []
        if !isLocalData {
            MovieClient.getAllGenres { [weak self] (genres, error) in
                guard let `self` = self else { return }
                if let genres = genres {
                    movieGenresString = self.setupGenre(ids: ids, genres: genres)
                    completion(movieGenresString)
                } else {
                    completion(nil)
                }
            }
        } else {
            let genres = LocalData.object.getAllGenres()
            movieGenresString = self.setupGenre(ids: ids, genres: genres)
            completion(movieGenresString)
        }
    }
    
    func setupGenre(ids: [Int], genres: [Genre]) -> [String] {
        var movieGenresString: [String] = []
        for id in ids {
            for genre in genres {
                if genre.id == id {
                    movieGenresString.append(genre.name)
                }
            }
        }
        return movieGenresString
    }
    
    func setupGenre(ids: [Int], genres: [Int:String]) -> [String] {
        var movieGenresString: [String] = []
        for id in ids {
            for genre in genres {
                if genre.key == id {
                    movieGenresString.append(genre.value)
                }
            }
        }
        return movieGenresString
    }
}

extension MovieDetailPresenter: FavoriteMoviesProtocol {
    func isMovieFavorite(movie: Movie) -> Bool {
        let favoriteMovies = LocalData.object.getAllFavoriteMovies()
        if favoriteMovies[movie.id] == nil {
            return false
        }
        return true
    }
    
    func handleMovieFavorite(movie: Movie) {
        if isMovieFavorite(movie: movie) == false {
            LocalData.object.makeMovieFavorite(movie: movie)
        } else {
            LocalData.object.makeMovieNotFavorite(movie: movie)
        }
    }
    
    func changeButtonImage(button: UIButton, movie: Movie) {
        let isFavorite = isMovieFavorite(movie: movie)
        if isFavorite == true {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedFull), for: .normal)
        } else {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedNormal), for: .normal)
        }
    }
}
