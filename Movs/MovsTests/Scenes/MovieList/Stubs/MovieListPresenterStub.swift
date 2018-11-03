//
//  MovieListPresenterStub.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

@testable import Movs

class MovieListPresenterStub: MovieListPresentationLogic {
    func presentMovies(response: MovieList.Response) {}
    func presentError(response: MovieList.Response) {}
    func presentNotFind(response: MovieList.Response) {}
}
