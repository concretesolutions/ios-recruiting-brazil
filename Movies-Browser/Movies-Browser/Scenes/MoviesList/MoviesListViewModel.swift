//
//  MoviesListViewModel.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

struct MoviesListState {
    // MARK: Data
    var page: Int = 1
    var featuredMovies: [Movie]
    var selectedMovie: Movie?
    var searchText: String = ""
    
    // MARK: Flow Related
    var refreshFeaturedMovies: Bool = true
    var presentSelectedMovie: Bool = false
    var presentEmptySearch: Bool = false
    var presentGenericError: Bool = false
    var presentLoading: Bool = false
}

final class MoviesListViewModel {
    let database = Database()
    
    private var movies: [Movie] = []{
        didSet {
            state.featuredMovies = movies
        }
    }
    
    var state: MoviesListState = MoviesListState(featuredMovies: []) {
        didSet {
            callback?(state)
        }
    }
    
    var callback: ((MoviesListState) -> ())? {
        didSet {
            callback?(state)
        }
    }
    
    public init(callback: ((MoviesListState) -> ())? ) {
        self.callback = callback
    }
}

// MARK: - Service -
extension MoviesListViewModel {
    func getFeaturedMovies(page: Int){
        state.presentLoading = true
        Service.request(router: .getFeaturedMovies(page)) { [weak self] (movieList: MoviesList?, success: Bool) in
            self?.state.presentLoading = false
            
            guard success else {
                self?.requestErrorOccured()
                return
            }
            self?.state.refreshFeaturedMovies = true
            if page == 1 {
                self?.movies = movieList?.movies ?? []
            } else {
                self?.movies += movieList?.movies ?? []
            }
        }
    }
}

// MARK: - Inputs -
extension MoviesListViewModel {
    func requestErrorOccured(){
        state.presentGenericError = true
    }
    
    func searchButtonWasTapped(searchText: String){
        let queryResult = movies.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
        state.featuredMovies = queryResult
        state.refreshFeaturedMovies = true
        state.searchText = searchText
        state.presentEmptySearch = queryResult.count == 0
    }
    
    func searchWasCleared(){
        state.searchText = ""
        state.presentEmptySearch = false
        state.featuredMovies = movies
        state.refreshFeaturedMovies = true
    }
    
    func movieWasTapped(id: Int){
        if state.featuredMovies.count > id {
            state.selectedMovie = state.featuredMovies[id]
            state.presentSelectedMovie = true
        }
    }
    
    func featuredMoviesDidRefresh(){
        state.refreshFeaturedMovies = false
    }
    
    func selectedMovieDetailDidPresent() {
        state.presentSelectedMovie = false
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        if state.featuredMovies.count > id {
            let movieId = state.featuredMovies[id].id
            return database.isFavorited(id: movieId)
        }
        return false
    }
    
    func didTapTryAgainButton(){
        state.presentGenericError = false
        getFeaturedMovies(page: state.page)
        state.refreshFeaturedMovies = true
    }
}

// MARK: - Events -
extension MoviesListViewModel {
    func viewWillAppear(){
        if movies.isEmpty {
            self.getFeaturedMovies(page: state.page)
        } else if !state.searchText.isEmpty {
            searchButtonWasTapped(searchText: state.searchText)
            return
        }
        state.refreshFeaturedMovies = true
    }
}
