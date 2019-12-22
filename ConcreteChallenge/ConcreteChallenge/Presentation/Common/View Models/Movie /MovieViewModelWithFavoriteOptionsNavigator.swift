//
//  MovieViewModelWithFavoriteOptionsNavigator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol MovieViewModelWithFavoriteOptionsNavigator: AnyObject {
    func userFavedMovie(movie: Movie)
    func userUnFavedMovie(movie: Movie)
}
