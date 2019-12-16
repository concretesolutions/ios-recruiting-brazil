//
//  FeedPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

class FeedPresenter: BasePresenter, FavoriteHandler {
    
    // MARK: - Properties -
    internal var feedView: FeedViewDelegate {
        guard let view = view as? FeedViewDelegate else {
            os_log("❌ - FeedPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("FeedPresenter was given to the wrong view")
        }
        return view
    }
    
    internal var favoritesView: FavoriteViewDelegate {
        guard let view = view as? FavoriteViewDelegate else {
            os_log("❌ - FeedPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("FeedPresenter was given to the wrong view")
        }
        return view
    }
    
    /// The movie data to be displayed
    internal var movies: [Movie] = [] {
        didSet {
            feedView.reloadFeed()
        }
    }
    
    // MARK: Computed
    var numberOfItems: Int {
        return movies.count
    }
    
    // MARK: - Init -
    override init() {
        guard type(of: self) != FeedPresenter.self else {
            os_log("❌ - FeedPresenter instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `FeedPresenter` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        super.init()
    }
    
    // MARK: - Methods -
    override func attachView(_ view: ViewDelegate) {
        super.attachView(view)
        loadFeed()
    }
    
    /**
     Override to do the necessary steps to load the feed data.
     */
    func loadFeed() {}
    
    func getItemData(item: Int) -> ItemViewData {
        
        guard item < self.numberOfItems else {
            os_log("❌ - Number of items > number of movies", log: Logger.appLog(), type: .fault)
            return ItemViewData.mockData
        }
        
        // Building the view data
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
        feedView.navigateToView(presenter: detailPresenter)
    }
    
    /// Do any steps to update the displayed data
    func updateData() {
        LocalService.instance.checkFavorites(on: movies)
        feedView.reloadFeed()
    }
    
    // MARK: - Favorite handler
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
        favoritesView.setFavorite(movie.isFavorite, tag: item)
        if movie.isFavorite {
            LocalService.instance.setFavorite(movie: movie)
        } else {
            LocalService.instance.removeFavorite(movie: movie)
        }
    }
}
