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
}

final class MoviesGridPresenter: MVPBasePresenter {
    
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
        
    }
    
    func didUnfavoriteItem(at row: Int) {
        
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
