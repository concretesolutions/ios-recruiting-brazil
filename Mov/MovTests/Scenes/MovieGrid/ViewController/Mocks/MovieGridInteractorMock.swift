//
//  MovieGridInteractorMock.swift
//  MovTests
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

@testable import Mov

class MovieGridInteractorMock: MovieGridInteractor {
    
    private var calls = Set<Method>()
    
    enum Method {
        case fetchMovieLit
    }
    
    func didCall(method: Method) -> Bool {
        return self.calls.contains(method)
    }
    
    func fetchMovieList(page: Int) {
        self.calls.insert(.fetchMovieLit)
    }
    
    
}
