//
//  MovieDescriptionPresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

final class MovieDescriptionPresenter {
    
    //MARK: - Contract Properties
    weak var view: MovieDescriptionView?
    var router: MovieDescriptionWireframe!
    
    //MARK: - Properties
    var movie: MovieEntity!
    var genres: [GenreEntity]!
    var poster: PosterEntity?
    var bank = UserSaves()
    
}

//MARK: - Contract Functions
extension MovieDescriptionPresenter: MovieDescriptionPresentation {
    
    func viewDidLoad() {
        view?.showMovieDescription(movie: movie, genres: GenreEntity.convertMovieGenresToString(genres: genres), poster: poster)
    }
    
    func didFavoriteMovie() {
        if !(bank.getAllFavoriteMovies().contains(where: { (movie) -> Bool in
            self.movie.id == movie.id
        })) {
            bank.add(movie: movie)
            if let poster = poster {
                bank.add(poster: poster)
            }
            
            //LocalDataSaving.store(data: movie, forKey: "FavoredMovie")
        }
        else {
            bank.remove(movie: movie, withPoster: true)
            //LocalDataSaving.remove(data: movie, forKey: "FavoredMovie")
        }
    }
}
