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
    func presentError()
}

final class MoviesGridPresenter: MVPBasePresenter {
    
    private let operation = FetchMoviesOperation()
    private var movies:[Movie] = []
    private var filteredMovies:[Movie] = []
    
    var view:MoviesGridPresenterView? {
        return self.baseView as? MoviesGridPresenterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.operation.onError = { [unowned self] err in
            self.view?.presentError()
        }
        
        self.operation.onSuccess = { [unowned self] movs in
            if self.operation.page == 1 {
                self.movies = movs
                self.view?.present(movies: movs)
            } else {
                self.movies.append(contentsOf: movs)
                //TODO: Increment movies
            }
        }
        
        self.operation.perform()
        self.view?.presentLoading()
    }
}

extension MoviesGridPresenter: MoviesGridViewPresenter {
    func updateSearchResults(searchText: String?) {
        guard let text = searchText, !text.isEmpty else {
            self.filteredMovies = []
            self.view?.present(movies: self.movies)
            return
        }
        
        self.filteredMovies = self.movies.filter {
            return $0.title.contains(text)
        }
        
        self.view?.present(movies: self.filteredMovies)
    }
}
