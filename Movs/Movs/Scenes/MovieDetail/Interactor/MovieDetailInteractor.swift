//
//  MovieDetailInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 28/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailBussinessLogic {
    var presenter: MovieDetailPresentationLogic!
    var movieDetailedWorker: MovieDetailWorkingLogic!
    var coreDataWorker: CoreDataWorkingLogic!
    
    init() {
        movieDetailedWorker = MovieDetailWorker()
        coreDataWorker = CoreDataWorker()
    }
    
    func fetchMovie(request: MovieDetail.Request) {
        movieDetailedWorker.fetch(movie: request.movie) { (movieDetailed, imageView, error) in
            if error != nil {
                return
            }
            
            if let movie = movieDetailed,
               let imageView = imageView {
                let isFavorite = self.coreDataWorker.isFavorite(id: movie.id)
                let response = MovieDetail.Response(movie: movie, imageView: imageView, isFavorite: isFavorite)
                self.presenter.present(response: response)
            }
        }
    }
    
    func favorite(movie: Movie) {
        coreDataWorker.favoriteMovie(movie: movie)
        let request = MovieDetail.Request(movie: movie)
        fetchMovie(request: request)
    }
}
