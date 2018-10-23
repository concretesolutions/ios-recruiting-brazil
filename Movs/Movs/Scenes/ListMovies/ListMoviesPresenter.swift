//
//  ListMoviesPresenter.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.


import UIKit

protocol ListMoviesPresentationLogic {
  func presentSomething(response: ListMovies.Something.Response)
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    weak var viewController: ListMoviesDisplayLogic?
    
      // MARK: Do something
    
    func presentSomething(response: ListMovies.Something.Response) {
        
        
    }
    
}
