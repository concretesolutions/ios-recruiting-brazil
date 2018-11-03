//
//  MovieDetailsPresenterMock.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

class MovieDetailsPresenterMock: MovieDetailsPresenter {
    
    var calls = Set<Methods>()
    
    var receivedUnit: MovieDetailsUnit!
    
    func presentDetails(of movie: MovieDetailsUnit) {
        self.calls.insert(.presentDetails)
        self.receivedUnit = movie
    }
    
    func presentFavoritesError() {
        self.calls.insert(.presentFavoritesError)
    }
}

extension MovieDetailsPresenterMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case presentDetails
        case presentFavoritesError
    }
    
}

