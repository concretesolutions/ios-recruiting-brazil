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
    
    public var hasAddFavorite: Bool = false
    public var hasLoadData: Bool = false
    public var hasSavedData: Bool = false
    public var hasCheckedFav: Bool = false
    public var hasDeletedFav: Bool = false
    
    func addFavorite(movie: PresentableMovieInterface) {
        hasAddFavorite = true
        saveData()
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
        if movieId == "429627"{
            return true
        }else{
            return false
        }
    }
    
    func deleteFavorite(movieForDeletion: Favorite) {
        hasDeletedFav = true
        saveData()
    }
    
}
