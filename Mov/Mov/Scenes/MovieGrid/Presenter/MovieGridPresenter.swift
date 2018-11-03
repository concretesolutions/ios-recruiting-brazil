//
//  MovieListPresenter.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


protocol MovieGridPresenter: class {
    func present(movies: [MovieGridUnit])
    
    func presentNetworkError()
    
    func presentNoResultsFound(for request: String)
    
    func presentGenericError()
}
