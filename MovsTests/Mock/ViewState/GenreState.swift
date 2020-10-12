//
//  GenreState.swift
//  MovsTests
//
//  Created by Joao Lucas on 12/10/20.
//

import Foundation
@testable import Movs

class GenreState {
    
    var success = false
    var error = false
    
    func onSuccess(genre: GenresDTO) {
        success = true
    }
    
    func onError(message: HTTPError) {}
}
