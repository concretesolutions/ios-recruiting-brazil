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
    private var noFavoritesMessage: ErrorMessageType = .missing("No favorites just yet...\nTry tapping the 💚 icon on a movie you like!")
    
    // MARK: - Methods -
    override func loadFeed() {
        
        view?.hideError()
        let moviesList = LocalService.instance.getFavoritesList()
        if moviesList.isEmpty {
            view?.displayError(noFavoritesMessage)
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
        
        // Handle last favorite removed
        if movies.isEmpty {
            // Delay to display the info
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                guard let self = self else { return }
                self.view?.displayError(self.noFavoritesMessage)
            }
        }
    }
}
