//
//  FiltersOptionInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class FiltersOptionInteractor: FiltersOptionBussinessLogic {
    var presenter: FiltersOptionPresentationLogic!
    var coreDataWorker: CoreDataWorkingLogic!
    var filtersOptionWorker: FiltersOptionWorkingLogic!
    
    var genresIds: [Int] = []
    var genresNames: [String] = []
    var dates: [String] = []
    var index: Int?
    
    init() {
        coreDataWorker = CoreDataWorker()
        filtersOptionWorker = FiltersOptionWorker()
    }
    
    func filtersTo(request: Filters.Option.Request) {
        switch request.type {
        case .date:
            presentDates()
        case .genre:
            presentGenres()
        }
    }
    
    func selectFilter(at index: Int) -> (String, String) {
        self.index = index
        if genresIds.isEmpty && !dates.isEmpty {
            return (dates[index], dates[index])
        } else if !genresIds.isEmpty {
            return (String(genresIds[index]), genresNames[index])
        }
        return ("", "")
    }
    
    private func presentDates() {
        let movies = coreDataWorker.fetchFavoriteMovies()
        var filters = movies.map({ (movie) -> String in
            return movie.releaseDate
        })
        filters.removeDuplicates()
        let response = Filters.Option.Response(filters: filters)
        dates = filters
        presenter.presentFilters(response: response)
    }
    
    private func presentGenres() {
        filtersOptionWorker.fetchGenres { (genreList, error) in
            if let genres = genreList?.genres {
                let filtersIds = genres.map({ (genre) -> Int in
                    return genre.id
                })
                let filtersNames = genres.map({ (genre) -> String in
                    return genre.name
                })
                let response = Filters.Option.Response(filters: filtersNames)
                self.genresIds = filtersIds
                self.genresNames = filtersNames
                self.presenter.presentFilters(response: response)
            }
        }
    }
    
}
