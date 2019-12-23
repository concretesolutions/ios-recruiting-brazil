//
//  SimilarMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol SimilarMoviesRepository: MoviesRepository {
    var similarMovieIdProvider: (() -> Int?)? { get set }
}
