//
//  FeedPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class FeedPresenter: BasePresenter {
    
    // MARK: - Properties -
    private var feedView: FeedViewDelegate {
        guard let view = view as? FeedViewDelegate else {
            os_log("❌ - FeedPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("FeedPresenter was given to the wrong view")
        }
        return view
    }
    
    private var movies: [Movie] = [] {
        didSet {
            feedView.reloadFeed()
        }
    }
    
    private var pagesLoaded: Int = 0
    
    // MARK: Computed
    var numberOfItems: Int {
        return movies.count
    }
    
    // MARK: Init
    override init() {
        super.init()
        loadFeed()
    }
    
    // MARK: - Methods -
    func loadFeed() {
        MovieClient.getPopular(page: 1) { [weak self] (movies, error) in
            
            if let error = error {
                os_log("❌ - Error loading movie feed: @", log: Logger.appLog(), type: .fault, error.localizedDescription)
                return
            }
            
            if let movies = movies {
                self?.movies = movies
                self?.feedView.reloadFeed()
            }
        }
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
        
        // TODO: Get favorite
        return ItemViewData(title: movie.title,
                            imageUrl: imageURL,
                            isFavorite: false)
    }
    
    func getHeaderData() -> FeedHeaderViewData {
        
        // TODO: Localize
        return FeedHeaderViewData(title: "Popular Movies",
                                  greeting: "Today's",
                                  searchBarPlaceholder: "Looking for a movie?")
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
}
