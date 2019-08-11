//
//  MovieObject.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

protocol MovieUpdateListener {
    func onFavoriteUpdate()
}

class MovieObject {
    let id: Int
    let title: String
    let release: Date
    let overview: String
    let posterPath: String?
    var poster: Data? = nil
    var isFavorite: Bool
    
    private var updateListeners: Array<MovieUpdateListener> = []
    func registerAsListener(_ updateListener: MovieUpdateListener) {
        self.updateListeners.append(updateListener)
    }
        
    init(id: Int, title: String, posterPath: String?, release: Date, overview: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.release = release
        self.overview = overview
        self.isFavorite = FavoriteMovieCRUD.fetch(byId: self.id) != nil
    }
    
    func findIndex(in array: Array<MovieObject>) -> Int? {
        do {
            return array.firstIndex(where: { cursor -> Bool in
                return cursor.id == self.id
            })
        } catch _ {
            return nil
        }
    }
    
    func addToFavorites(shouldTriggerListeners: Bool = true) {
        self.isFavorite = true
        FavoriteMovieCRUD.add(from: self, shouldTriggerListeners: shouldTriggerListeners)
        for updateListener in updateListeners {
            updateListener.onFavoriteUpdate()
        }
    }
    
    func removeFromFavorites(shouldTriggerListeners: Bool = true) {
        self.isFavorite = false
        FavoriteMovieCRUD.delete(self, shouldTriggerListeners: shouldTriggerListeners)
        for updateListener in updateListeners {
            updateListener.onFavoriteUpdate()
        }
    }
}
