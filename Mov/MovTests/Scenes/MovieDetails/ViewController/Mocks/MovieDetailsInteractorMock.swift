//
//  MovieDetailsInteractorMock.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

class MovieDetailsInteractorMock: MovieDetaisInteractor {
    var calls = Set<Methods>()
    
    var receivedDetailsMovie: Movie!
    var receivedToggleMovie: Movie!

    func getDetails(of movie: Movie) {
        self.calls.insert(.getDetails)
        self.receivedDetailsMovie = movie
    }
    
    func toggleFavorite(_ movie: Movie) {
        self.calls.insert(.toggleFavorite)
        self.receivedToggleMovie = movie
    }
    
}

extension MovieDetailsInteractorMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case getDetails
        case toggleFavorite
    }
    
}

