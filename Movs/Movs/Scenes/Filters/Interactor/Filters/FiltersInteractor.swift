//
//  FiltersInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class FiltersInteractor: FiltersBussinessLogic, FiltersDataStore {
    var presenter: FiltersPresentationLogic!
    var coreDataWorker: CoreDataWorkingLogic!
    var type: Filters.FiltersType?
    
    init() {
        coreDataWorker = CoreDataWorker()
    }
    
    func applyFilters(request: Filters.Request.Filters) {
        var movies: [Movie] = []
        
        if let date = request.dateFilter,
           let genre = request.genreFilter {
            movies = coreDataWorker.fetchMoviesFiltered(by: date, by: genre)
        } else if let date = request.dateFilter {
            movies = coreDataWorker.fetchFilteredYear(date)
        } else if let genre = request.genreFilter {
            movies = coreDataWorker.fetchFilteredGenre(genre)
        }
        
        let response = Filters.Response(movies: movies)
        presenter.present(response: response)
    }

    
    func storeFilter(request: Filters.Request) {
        type = request.type
    }
}
