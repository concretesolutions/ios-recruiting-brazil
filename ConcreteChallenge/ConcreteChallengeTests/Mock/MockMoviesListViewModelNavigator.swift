//
//  MockMoviesListViewModelNavigator.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
@testable import ConcreteChallenge

class MockMoviesListViewModelNavigator: MoviesListViewModelNavigator {
    
    var movieWasSelectedCompletion: (() -> Void)?
    
    init() {
        
    }
    
    func movieWasSelected(movie: Movie) {
        movieWasSelectedCompletion?()
    }
    
    func movieWasFaved(movie: Movie) {
        
    }
    
    func movieWasUnfaved(movie: Movie) {
        
    }
}
