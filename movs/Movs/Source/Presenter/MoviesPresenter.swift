//
//  MoviesPresenter.swift
//  movs
//
//  Created by Lorien Moisyn on 17/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MoviesPresenter {
    
    let dm = DataModel.sharedInstance

    var movies: [Movie] = []
    var genres: [Genre] = []
    var favorites: [Movie] = []
    var genreFilters: [String] = []
    var yearFilters: [String] = []
    var moviesVC: BaseViewController!
    var repository: AlamoRemoteSource!
    var disposeBag = DisposeBag()
    var pageIndex = 1
    var isRequesting = false
    var isFiltering = false
    
    init(vc: BaseViewController) {
        moviesVC = vc
        repository = AlamoRemoteSource()
    }
    
    func getNewPage() {
        pageIndex += 1
        getMovies()
    }
    
    func getMovies() {
        isRequesting = true
        repository
            .getTopMovies(at: pageIndex)
            .do(onSuccess: { (movies) in
                self.movies += movies
            })
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { movies in
                guard !movies.isEmpty else {
                    self.moviesVC.showErrorLayout()
                    return
                }
                self.movies.forEach{
                    if self.isFavorite($0) {
                        self.markAsFavorite($0)
                    }
                }
                self.moviesVC.updateLayout()
            }, onCompleted: {
                self.isRequesting = false
            })
            .disposed(by: disposeBag)
    }
    
    func getFavorites() {
        guard !movies.isEmpty else {
            favorites = dm.movies.filter { dm.favoriteIds.contains($0.id) }
            moviesVC.updateLayout()
            return
        }
        movies.forEach{
            if isFavorite($0) {
                markAsFavorite($0)
                return
            }
        }
        moviesVC?.updateLayout()
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        return dm.favoriteIds.contains(movie.id)
    }
    
    func markAsFavorite(_ movie: Movie) {
        movie.isFavorite = true
        favorites.append(movie)
        dm.favoriteIds.insert(movie.id)
        moviesVC?.updateLayout()
    }
    
    func unfavorite(_ movie: Movie) {
        movie.isFavorite = false
        favorites = favorites.filter{ $0.id != movie.id}
        dm.favoriteIds.remove(movie.id)
        moviesVC?.updateLayout()
    }
    
    func getGenres(for movie: Movie) -> [String] {
        let genres = dm.genres.filter{ movie.genreIds.contains($0.id) }
        var genreNames: [String] = []
        genres.forEach{ genreNames.append($0.name) }
        return genreNames
    }
    
    func filteredBy(genreNames: [String]) -> [Movie]{
        getFavorites()
        let filtered = favorites.filter{ movie in
            let movieGenres = self.getGenres(for: movie)
            return !Set(genreNames).intersection(movieGenres).isEmpty
        }
        return filtered
    }
    
    func filteredBy(years: [String]) -> [Movie]{
        getFavorites()
        let filtered = favorites.filter{ movie in
            let movieYear = String(movie.date.split(separator: "-")[0])
            return years.contains(movieYear)
        }
        return filtered
    }
    
    func combineFilters(genres: [String], years: [String]) {
        isFiltering = true
        genreFilters = genres
        yearFilters = years
        let filteredByGenre = genres.isEmpty ? favorites : filteredBy(genreNames: genres)
        let filteredByYear = years.isEmpty ? favorites : filteredBy(years: years)
        let filteredByBoth = filteredByGenre.filter{ movie in
            filteredByYear.contains(where: { $0.id == movie.id })
        }
        favorites = filteredByBoth
        moviesVC.updateLayout()
    }
    
}
