//
//  MovieObject.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

class MovieObject {
    let id: Int
    let title: String
    let release: Date
    let overview: String
    let posterPath: String?
    var poster: Data? = nil
    var isFavorite: Bool
        
    init(id: Int, title: String, posterPath: String?, release: Date, overview: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.release = release
        self.overview = overview
        self.isFavorite = FavoriteMovieFetcher.fetch(byId: self.id) != nil
    }
    
    func addToFavorites() {
        FavoriteMovieFetcher.add(from: self)
    }
    
    func removeFromFavorites() {
        if let favoriteMovie = FavoriteMovieFetcher.fetch(byId: self.id) {
            FavoriteMovieFetcher.delete(favoriteMovie)
        }
    }
}
