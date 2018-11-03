//
//  MoviesGridPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol MoviesGridPresenterView: ViewProtocol {
    func presentLoading()
    func present(movies:[Movie])
    func present(moreMovies:[Movie], startingAt row:Int)
    func present(searchResults:[Movie])
    func presentError()
    func presentEmptySearch()
    func updateMovie(at row:Int, isFavorite:Bool)
    func updateItems(at rows:[Int], favoriteFlags:[Bool])
}

final class MoviesGridPresenter: MVPBasePresenter {
    
    private let favoritesDAO = try! FavoriesDAO()
    private let operation = FetchMoviesOperation()
    
    private var movies:[Movie] = []
    private var filteredMovies:[Movie] = []
    
    private(set) var isSearching:Bool = false
    
    var view:MoviesGridPresenterView? {
        return self.baseView as? MoviesGridPresenterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.operation.onError = { [unowned self] err in
            if let error = err as? APIError {
                if error == .badParsing {
                    self.operation.perform()
                } else {
                    self.view?.presentError()
                }
            }
        }
        
        self.operation.onSuccess = { [unowned self] movs in
            if self.operation.page == 1 {
                self.movies = movs
                self.view?.present(movies: movs)
            } else {
                if !self.isSearching {
                    let row = self.movies.count
                    self.movies.append(contentsOf: movs)
                    self.view?.present(moreMovies: movs, startingAt: row)
                }
            }
        }
        
        self.operation.perform()
        self.view?.presentLoading()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.refreshChangedMovies()
    }
    
    func refreshChangedMovies() {
        var rows = [Int]()
        var flags = [Bool]()
        for i in 0..<self.movies.count {
            let mov = self.movies[i]
            let movieIsFavorite = self.favoritesDAO.contains(movie: mov)
            if mov.isFavorite != movieIsFavorite {
                self.movies[i].isFavorite = movieIsFavorite
                rows.append(i)
                flags.append(movieIsFavorite)
            }
        }
        self.view?.updateItems(at: rows, favoriteFlags: flags)
    }
    
    func getFilteredMovies(searchText:String) -> [Movie] {
        return self.movies.filter { movie in
            let movieTitle = movie.title.lowercased()
            let query = searchText.lowercased()
            return movieTitle.contains(query)
        }
    }
}

extension MoviesGridPresenter: MoviesGridViewPresenter {
    
    func didSelectItem(at row: Int) {
        if self.isSearching {
            self.coordinator?.data = self.filteredMovies[row]
        } else {
            self.coordinator?.data = self.movies[row]
        }
        self.coordinator?.next()
    }
    
    func didFavoriteItem(at row: Int) {
        do {
            let movie = self.movies[row]
            try self.favoritesDAO.add(favoriteMovie: movie)
            self.movies[row].isFavorite = true
            self.view?.updateMovie(at: row, isFavorite: true)
        } catch {}
    }
    
    func didUnfavoriteItem(at row: Int) {
        do {
            let movie = self.movies[row]
            try self.favoritesDAO.remove(favoriteMovie: movie)
            self.movies[row].isFavorite = false
            self.view?.updateMovie(at: row, isFavorite: false)
        } catch {}
    }
    
    func loadMoreMovies() {
        self.operation.performFromNextPage()
    }
    
    func searchBarDidBeginEditing() {
        self.isSearching = true
    }
    
    func searchBarDidPressCancelButton() {
        self.isSearching = false
        self.view?.present(movies: self.movies)
    }
    
    func updateSearchResults(searchText: String?) {
        guard let text = searchText, !text.isEmpty else {
            return
        }
        
        self.filteredMovies = self.getFilteredMovies(searchText: text)
        
        self.view?.present(searchResults: self.filteredMovies)
        
        if filteredMovies.isEmpty {
            self.view?.presentEmptySearch()
        }
    }
}
