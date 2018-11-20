//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class MoviesInteractor: MoviesUseCase {
    
    // MARK: - Properties
    
    var output: MoviesInteractorOutput!
    private var current: [Movie] = []
    
    // MARK: - MoviesUseCase protocol functions
    
    func readMoviesFor(page: Int) {
        APIDataManager.readPopularFor(page: page) {
            self.current.append(contentsOf: $0)
            self.output.didReadMoviesForPage(page, $0)
        }
    }
    
    func filterMoviesWith(name: String) {
        let filtered = self.current.filter { return $0.title.contains(name) }
        output.didFilterMoviesWithName(name, filtered)
    }
    
    func removeFilter() {
        output.didRemoveFilter(self.current)
    }
    
}
