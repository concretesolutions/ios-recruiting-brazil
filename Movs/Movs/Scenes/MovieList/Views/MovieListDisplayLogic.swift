//
//  MovieListDisplayLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListDisplayLogic: class {
    /**
     Display movies.
     
     - parameters:
         - viewModel: Data to be displayed.
     */
    func displayMovies(viewModel: MovieList.ViewModel.Success)
    
    /**
     Display error view.
     
     - parameters:
         - viewModel: Data of error to be displayed.
     */
    func displayError(viewModel: MovieList.ViewModel.Error)
    
    /**
     Display not find view.
     
     - parameters:
         - viewModel: Data of error to be displayed.
     */
    func displayNotFind(viewModel: MovieList.ViewModel.Error)
}
