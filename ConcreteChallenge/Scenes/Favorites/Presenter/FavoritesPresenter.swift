//
//  FavoritesPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class FavoritesPresenter: BasePresenter {
    
    // MARK: - Properties -
    private var favoritesView: FeedViewDelegate {
        guard let view = view as? FeedViewDelegate else {
            os_log("❌ - FavoritesPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("FavoritesPresenter was given to the wrong view")
        }
        return view
    }
    
    /// The movie data to be displayed
    private var movies: [Movie] = [] {
        didSet {
            favoritesView.reloadFeed()
        }
    }
    
    // MARK: Computed
    var numberOfItems: Int {
        return movies.count
    }
    
    // MARK: - Methods -
    override func attachView(_ view: ViewDelegate) {
        super.attachView(view)
        loadFavorites()
    }
    
    func loadFavorites() {
        
        let moviesList = LocalService.instance.getFavoritesList()
        guard !moviesList.isEmpty else {
            // TODO: Handle having no favorites
            return
        }
        movies = moviesList
    }
    
    func getItemData(item: Int) -> ItemViewData {
        
        guard item < self.numberOfItems else {
            os_log("❌ - Number of items > number of movies", log: Logger.appLog(), type: .fault)
            return ItemViewData.mockData
        }
        
        let movie = movies[item]
        let imageURL: URL?
        if let path = movie.backdropPath {
            imageURL = ImageEndpoint.image(width: 780, path: path).completeURL
        } else {
            imageURL = nil
        }
        
        return ItemViewData(title: movie.title,
                            imageUrl: imageURL,
                            isFavorite: movie.isFavorite)
    }
    
    func selectItem(item: Int) {
        guard item < self.numberOfItems else {
            os_log("❌ - Number of items > number of movies", log: Logger.appLog(), type: .fault)
            return
        }
        
        let movie = movies[item]
        let detailPresenter = DetailPresenter(movie: movie)
        favoritesView.navigateToView(presenter: detailPresenter)
    }
}

extension FavoritesPresenter: FavoriteHandler {
    func favoriteStateChanged(tag: Int?) {
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
