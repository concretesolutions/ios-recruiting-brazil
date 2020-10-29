//
//  MoviesBusinessLogic.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesBusinessLogic: AnyObject {
    func fetchMovies(request: Movies.FetchMovies.Request)
}
