//
//  MovieViewModelWithFavoriteOptionsNavigator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// its a delegate with important favorite information to make the navigation
protocol MovieViewModelWithFavoriteOptionsNavigator: AnyObject {
    func userFavedMovie(movie: Movie)
    func userUnFavedMovie(movie: Movie)
}
