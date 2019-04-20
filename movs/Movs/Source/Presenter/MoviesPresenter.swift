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
    var moviesVC: BaseViewController!
    var repository: AlamoRemoteSource!
    var disposeBag = DisposeBag()
    var pageIndex = 1
    var isRequesting = false
    
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
    
    func getGenres(for movie: Movie) -> String {
        let genres = dm.genres.filter{ movie.genreIds.contains($0.id) }
        var names: [String] = []
        genres.forEach{ names.append($0.name) }
        return names.joined(separator: " / ")
    }
    
}
