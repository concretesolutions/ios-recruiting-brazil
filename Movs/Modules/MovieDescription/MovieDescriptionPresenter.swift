//
//  MovieDescriptionPresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

class MovieDescriptionPresenter: MovieDescriptionPresentation {
    
    //MARK: - Contract Properties
    weak var view: MovieDescriptionView?
    var router: MovieDescriptionWireframe!
    
    //MARK: - Properties
    var movie: MovieEntity!
    var genres: [GenreEntity]!
    var poster: PosterEntity?
    
    //MARK: - Contract Functions
    func viewDidLoad() {
        view?.showMovieDescription(movie: movie, genres: GenreEntity.convertMovieGenresToString(genres: genres), poster: poster)
    }
    
    func didFavoriteMovie() {
        if !(UserSaves.favoriteMovies.contains(where: { (movie) -> Bool in
            self.movie.id == movie.id
        })) {
            UserSaves.favoriteMovies.append(movie)
            if let poster = poster {
                UserSaves.posters.append(poster)
            }
            
            //LocalDataSaving.store(data: movie, forKey: "FavoredMovie")
        }
        else {
            UserSaves.favoriteMovies.removeAll { (movie) -> Bool in
                self.movie.id == movie.id
            }
            UserSaves.posters.removeAll { (poster) -> Bool in
                self.movie.id == poster.movieId
            }
            //LocalDataSaving.remove(data: movie, forKey: "FavoredMovie")
        }
    }
    
    
}
