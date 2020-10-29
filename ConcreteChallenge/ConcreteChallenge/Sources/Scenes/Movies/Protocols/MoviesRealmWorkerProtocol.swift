//
//  MoviesRealmWorkerProtocol.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

protocol MoviesRealmWorkerProtocol: AnyObject {
    func saveMovie(movie: Movie, indexPath: IndexPath)
}
