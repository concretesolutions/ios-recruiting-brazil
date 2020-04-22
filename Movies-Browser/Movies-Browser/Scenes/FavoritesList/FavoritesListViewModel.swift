//
//  FavoritesListViewModel.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

struct FavoriteListState {
    // MARK: Data
    var favoriteMovies: [Movie]
    var selectedMovie: Movie?
    var searchText: String = ""
    
    // MARK: Flow Related
    var refreshFavoriteMovies: Bool = true
    var presentSelectedMovie: Bool = false
    var presentEmptyFavorites: Bool = true
    var presentEmptySearch: Bool = false
}

final class FavoritesListViewModel {
    let database = Database()
    
    private var movies: [Movie] {
        didSet {
            state.favoriteMovies = movies
            state.presentEmptyFavorites = state.favoriteMovies.count == 0
        }
    }
    
    var state: FavoriteListState = FavoriteListState(favoriteMovies: []) {
        didSet {
            callback?(state)
        }
    }
    
    var callback: ((FavoriteListState) -> ())? {
        didSet {
            callback?(state)
        }
    }
    
    public init(callback: ((FavoriteListState) -> ())? ) {
        self.callback = callback
        self.movies = database.getFavoritesList()
    }
}

// MARK: - Inputs -
extension FavoritesListViewModel {
    func searchButtonWasTapped(searchText: String){
        let queryResult = movies.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
        state.favoriteMovies = queryResult
        state.refreshFavoriteMovies = true
        state.searchText = searchText
        state.presentEmptySearch = queryResult.count == 0
    }
    
    func searchWasCleared(){
        state.searchText = ""
        state.presentEmptySearch = false
        state.favoriteMovies = movies
        state.refreshFavoriteMovies = true
        state.presentEmptyFavorites = state.favoriteMovies.count == 0
    }
    
    func unfavoriteButtonWasTapped(indexPath: IndexPath){
        let id = state.favoriteMovies[indexPath.row].id
        database.deleteFavorite(id: id)
        movies = database.getFavoritesList()
    }
    
    func movieWasTapped(id: Int){
        if state.favoriteMovies.count > id {
            state.selectedMovie = state.favoriteMovies[id]
            state.presentSelectedMovie = true
        }
    }
    func favoriteMoviesDidRefresh(){
        state.refreshFavoriteMovies = false
    }
    func selectedMovieDetailDidPresent() {
        state.presentSelectedMovie = false
    }
}

// MARK: - Events -
extension FavoritesListViewModel {
    func viewWillAppear(){
        if !state.searchText.isEmpty {
            searchButtonWasTapped(searchText: state.searchText)
            return
        }
        movies = database.getFavoritesList()
        state.refreshFavoriteMovies = true
    }
}
