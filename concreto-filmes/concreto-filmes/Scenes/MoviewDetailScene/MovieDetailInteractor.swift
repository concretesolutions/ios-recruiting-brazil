//
//  MovieDetailInteractor.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailBusinessLogic {
    func presentMovie()
}

protocol MovieDetailDataStore {
    var movie: Movie? {get set}
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var movie: Movie?
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?

    func presentMovie() {
        guard let movie = self.movie else {
            return
        }
        self.presenter?.presentMovie(movie: movie)
    }
}
