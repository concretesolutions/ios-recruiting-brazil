//
//  MoviesListState.swift
//  MovsTests
//
//  Created by Joao Lucas on 09/10/20.
//

import Foundation
@testable import Movs

class MoviesListState {
    
    var success = false
    var loading = false
    var error = false
    
    func onSuccess(movies: MoviesDTO) {
        success = true
    }
    
    func onLoading() {}
    
    func onError(message: HTTPError) {}
}
