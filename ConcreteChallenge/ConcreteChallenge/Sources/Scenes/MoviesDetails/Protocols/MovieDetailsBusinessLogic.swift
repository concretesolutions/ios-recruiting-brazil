//
//  MovieDetailsBusinessLogic.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsBusinessLogic: AnyObject {
    func saveMovie(request: MovieDetails.SaveMovie.Request)
    func deleteMovie(request: MovieDetails.DeleteMovie.Request)
}
