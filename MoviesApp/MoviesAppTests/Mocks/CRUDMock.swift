//
//  CRUDMock.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/18/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation

@testable import MoviesApp

class CRUDMock: FavoriteCRUDInterface{
    
    var hasAddFavorite: Bool = false
    var hasLoadData: Bool = false
    var hasSavedData: Bool = false
    var hasCheckedFav: Bool = false
    var hasFiterFav: Bool = false
    var hasDeletedFav: Bool = false
    
    
    func addFavorite(movie: SimplifiedMovie) {
        hasAddFavorite = true
    }
    
    func loadData() throws -> [Favorite] {
        hasLoadData = true
        return []
    }
    
    func saveData() {
        hasSavedData = true
    }
    
    func checkFavoriteMovie(movieId: String) -> Bool {
        hasCheckedFav = true
        if movieId == "429617"{
            return true
        }else{
            return false
        }
    }
    
    func filterFavorites(format: String, filter: String) -> [Favorite] {
        hasFiterFav = true
        return []
    }
    
    func deleteFavorite(movieForDeletion: Favorite) {
        hasDeletedFav = true
    }
    
}
