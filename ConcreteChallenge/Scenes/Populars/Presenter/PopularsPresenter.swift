//
//  PopularsPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class PopularsPresenter: FeedPresenter {
    
    // MARK: - Properties -    
    /// Controls which page to load next on
    private var pagesLoaded: Int = 0
    
    private var maxPages: Int = 500
    
    private var isSearching: Bool = false
    
    // MARK: - Methods -
    override func loadFeed() {
        MovieClient.getPopular(page: 1) { [weak self] (movies, error) in
            
            if let error = error {
                os_log("❌ - Error loading movie feed: @", log: Logger.appLog(), type: .fault, error.localizedDescription)
                return
            }
            
            if let movies = movies {
                self?.movies = movies
            }
        }
        pagesLoaded = 1
    }
    
    func loadMoreItems() {
        guard pagesLoaded <= maxPages else { return }
        pagesLoaded += 1
        MovieClient.getPopular(page: pagesLoaded) { [weak self] (movies, error) in
            
            if let error = error {
                os_log("❌ - Error loading movie feed: @", log: Logger.appLog(), type: .fault, error.localizedDescription)
                return
            }
            
            if let movies = movies {
                self?.movies.append(contentsOf: movies)
            }
        }
    }
    
    override func getItemData(item: Int) -> ItemViewData {
        
        let itemData = super.getItemData(item: item)
        
        // Prefetching if necessary
        if item > numberOfItems - 5 {
            loadMoreItems()
        }
        
        return itemData
    }
    
    func getHeaderData() -> PopularHeaderViewData {
        
        // TODO: Localize
        return PopularHeaderViewData(title: "Popular Movies",
                                  greeting: "Today's",
                                  searchBarPlaceholder: "Looking for a movie?")
    }
    
    /// Do any steps to update the displayed data
    override func updateData() {
        LocalService.instance.checkFavorites(on: movies)
        feedView.reloadFeed()
    }
    
    /**
     Search a movie from some text.
     - Parameter text:
     */
    func searchMovie(_ text: String?) {
        guard let text = text, text != "" else {
            os_log("Tried to search with no text", log: Logger.appLog(), type: .info)
            if isSearching {
                loadFeed()
            }
            isSearching = false
            return
        }
        
        isSearching = true
        
        MovieClient.search(text) { [weak self] (movies, error) in
            if let error = error {
                os_log("❌ - Error searching movies: @", log: Logger.appLog(), type: .fault, error.localizedDescription)
                return
            }
            
            if let movies = movies {
                self?.movies = movies
                self?.feedView.resetFeedPosition()
            }
        }
    }
}
