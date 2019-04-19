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
    var favorites: [Movie] = []
    var moviesVC: MoviesViewController!
    var repository: AlamoRemoteSource!
    var disposeBag = DisposeBag()
    var pageIndex = 1
    var isRequesting = false
    
    init(vc: MoviesViewController) {
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
                self.movies.forEach{
                    if self.isFavorite($0) {
                        self.markAsFavorite($0)
                        return
                    }
                }
                DataModel.sharedInstance.movies = self.movies
            })
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { _ in
                self.moviesVC.updateLayout()
            }, onCompleted: {
                self.isRequesting = false
            })
            .disposed(by: disposeBag)
    }
    
    func getFavorites() {
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
    
}
