//
//  MovieViewPresenterDelegate.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

protocol MovieViewPresenterDelegate: class {
    func selectedMovie(movie: Movie)
}
