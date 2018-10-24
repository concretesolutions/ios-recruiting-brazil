//
//  ListMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesBusinessLogic {
    func fetchPopularMovies(request: ListMovies.Fetch.Request)
}

class ListMoviesInteractor: ListMoviesBusinessLogic {
  
    var presenter: ListMoviesPresentationLogic?
    var worker: ListMoviesWorker = ListMoviesWorker()
  
    // MARK: Do request
    func fetchPopularMovies(request: ListMovies.Fetch.Request) {
        worker.fetchPopularMovies(page: 1) { (response) in
            
        }
    }
    
    
}
