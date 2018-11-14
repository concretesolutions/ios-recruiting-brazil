//
//  MovieDetailsInteractor.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 14/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MovieDetailsInteractor {
    
    // MARK: - VIPER
    var presenter: MovieDetailsPresenter?
    
    // MARK: - Parameters
    private var movieID: Int!
    private var movie: MovieDetail? {
        didSet {
            if let movieDetail = movie {
                self.presenter?.movieLoaded(title: movieDetail.title, favorite: false, genre: movieDetail.genres!, year: movieDetail.release_date, overview: movieDetail.overview, imageURL: movieDetail.poster_path)
            }
        }
    }
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    // FROM PRESENTER
    
    func fetchMovie() {
        ServerManager.getMovieByID(movieID: self.movieID) { (movieDetail, status) in
            switch status {
            case .error:
                print("-> Error")
//                self.presenter?.loadingError()
            case .okay:
                print("-> Movies: \(movieDetail!.title)")
                if let movie = movieDetail {
                    self.movie = movie
                }
//                self.moviesVisible = popularMovies
//                self.presenter?.loadedMovies()
            }
        }
    }
    
}
