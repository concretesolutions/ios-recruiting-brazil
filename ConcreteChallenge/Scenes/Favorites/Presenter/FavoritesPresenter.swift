//
//  FavoritesPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class FavoritesPresenter: FeedPresenter {
    
    // MARK: - Properties -
    override func loadFeed() {
        
        let moviesList = LocalService.instance.getFavoritesList()
        guard !moviesList.isEmpty else {
            // TODO: Handle having no favorites
            return
        }
        movies = moviesList
    }
    
    override func updateData() {
        loadFeed()
    }

    override func favoriteStateChanged(tag: Int?) {
        guard let item = tag else {
            os_log("❌ - Favorite had no tag", log: Logger.appLog(), type: .fault)
            return
        }
        
        guard item < self.numberOfItems else {
            os_log("❌ - Number of items > number of movies", log: Logger.appLog(), type: .fault)
            return
        }
        
        let movie = movies[item]
        movie.isFavorite = !movie.isFavorite
        
        if movie.isFavorite {
            LocalService.instance.setFavorite(movie: movie)
        } else {
            LocalService.instance.removeFavorite(movie: movie)
            movies.remove(at: item)
        }
        
        favoritesView.setFavorite(movie.isFavorite, tag: item)
    }
}
