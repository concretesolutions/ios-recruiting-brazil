//
//  SeachMoviesViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol SeachMoviesViewModel {
    var moviesViewModel: MoviesListViewModel { get }
    
    func userUpdatedSearchQuery(query: String)
    func userTappedSearchButton()
    func userTappedCancelSearch()
    func userBeganTheSearch()
}

class DefaultSeachMoviesViewModel: SeachMoviesViewModel {
    var moviesViewModel: MoviesListViewModel
    private var moviesSearchRepository: SearchMoviesRepository
    private var currentQuery: String?
    
    init(moviesSearchRepository: SearchMoviesRepository,
         movieViewModelInjector: Injector<MoviesListViewModel, (repository: MoviesRepository, emptyState: String)>) {
        self.moviesSearchRepository = moviesSearchRepository
        self.moviesViewModel = movieViewModelInjector((moviesSearchRepository, "No search results."))
        
        self.moviesSearchRepository.searchQueryProvider = { [weak self] in
            return self?.currentQuery ?? nil
        }
    }

    func userUpdatedSearchQuery(query: String) {
        self.currentQuery = query
    }
    
    func userTappedSearchButton() {
        self.moviesViewModel.deleteAllMovies()
        self.moviesViewModel.thePageReachedTheEnd()
    }
    
    func userTappedCancelSearch() {
        self.moviesViewModel.deleteAllMovies()
    }
    
    func userBeganTheSearch() {
        
    }
}
