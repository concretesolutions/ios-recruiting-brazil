//
//  MoviesListDelegate.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

protocol MoviesListDelegate: class {
    func toggleLoading(_ isLoading: Bool)
    func moviesListUpdated()
    func errorFetchingMovies(error: APIError)
}
