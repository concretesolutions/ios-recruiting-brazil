//
//  MoviesListUseCaseMock.swift
//  MovsTests
//
//  Created by Joao Lucas on 11/10/20.
//

import Foundation
import RealmSwift
@testable import Movs

class MoviesListUseCaseMock: MoviesListUseCase {
    
    override func addToFavorites(realm: Realm, movie: ResultMoviesDTO, onSuccess: @escaping (() -> Void)) {
        onSuccess()
    }
    
    override func removeFavorites(realm: Realm, movie: ResultMoviesDTO, onSuccess: @escaping (() -> Void)) {
        onSuccess()
    }
}
