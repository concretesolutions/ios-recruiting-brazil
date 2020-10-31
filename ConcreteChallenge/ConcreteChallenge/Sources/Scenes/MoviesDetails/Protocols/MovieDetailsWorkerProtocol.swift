//
//  MovieDetailsWorkerProtocol.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsWorkerProtocol: AnyObject {
    func saveMovie(movie: Movie)
    func deleteMovie(movie: Movie)
}
