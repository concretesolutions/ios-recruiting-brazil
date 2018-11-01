//
//  MovieListPresentationLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListPresentationLogic {
    func presentMovies(response: MovieList.Response)
    func presentError(response: MovieList.Response)
    func presentNotFind(response: MovieList.Response)
}
