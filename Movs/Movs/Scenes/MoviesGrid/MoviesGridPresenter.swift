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
    func presentError()
    func presentEmptySearch()
}

final class MoviesGridPresenter: MVPBasePresenter {
    
    private let operation = FetchMoviesOperation()
    
    private(set) var isSearching:Bool = false
    
    private var movies:[Movie] = []
    private var filteredMovies:[Movie] = []
    
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
}

extension MoviesGridPresenter: MoviesGridViewPresenter {
    
    func loadMoreMovies() {
        self.operation.performFromNextPage()
    }
    
    func updateSearchResults(searchText: String?) {
        guard let text = searchText, !text.isEmpty else {
            self.isSearching = false
            self.filteredMovies = []
            self.view?.present(movies: self.movies)
            return
        }
        self.isSearching = true
        
        self.filteredMovies = self.movies.filter {
            return $0.title.contains(text)
        }
        
        if self.filteredMovies.isEmpty {
            self.view?.presentEmptySearch()
        } else {
            self.view?.present(movies: self.filteredMovies)
        }
    }
}
