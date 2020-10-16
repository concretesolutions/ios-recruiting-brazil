//
//  GenreListState.swift
//  MovsTests
//
//  Created by Joao Lucas on 15/10/20.
//

import Foundation
@testable import Movs

class GenreListState {
    
    var success = false
    var loading = false
    var error = false
    
    func onSuccess(genre: GenresDTO) {
        success = true
    }
    
    func onLoading() { }
    
    func onError(message: HTTPError) { }
    
}
