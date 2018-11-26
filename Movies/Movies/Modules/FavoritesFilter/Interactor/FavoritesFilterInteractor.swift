//
//  FavoritesFilterInteractor.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class FavoritesFilterInteractor: FavoritesFilterUseCase {
    
    // MARK: - Properties
    
    var output: FavoritesFilterInteractorOutput!
    
    // MARK: - FavoritesFilterUseCase protocol functions
    
    func getGenres() {
        DispatchQueue.main.async {
            let allGenres = GenreDataManager.readGenres()
            var genres: [GenreFilterItem] = []
            allGenres.forEach { g in
                if (MovieDataManager.genresFilter.contains { return $0.id == g.id && $0.name == g.name }) {
                    genres.append((g, true))
                } else {
                    genres.append((g, false))
                }
            }
            self.output.didGet(genres: genres)
        }
    }
    
    func getYears() {
        let allYears = Set(MovieDataManager.readFavoriteMovieYears())
        var years: [YearFilterItem] = []
        allYears.forEach { y in
            if MovieDataManager.yearsFilter.contains(y) {
                years.append((y, true))
            } else {
                years.append((y, false))
            }
        }
        self.output.didGet(years: years)
    }
    
    func add(genre: Genre) {
        MovieDataManager.genresFilter.append(genre)
    }
    
    func remove(genre: Genre) {
        MovieDataManager.genresFilter.removeAll { return $0.id == genre.id && $0.name == genre.name }
    }
    
    func add(year: Int) {
        MovieDataManager.yearsFilter.append(year)
    }
    
    func remove(year: Int) {
        MovieDataManager.yearsFilter.removeAll { return $0 == year }
    }
    
    
}
