//
//  FavoriteListPresenter.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

protocol FavoriteListViewProtocol: NSObjectProtocol {
    func onLoadedFavoriteMovies(movies: [MovieData])
    func onFilterResult(movies: [MovieData])
    func onFilterEmptyResult()
}

class FavoriteListPresenter  {
    weak var view: FavoriteListViewProtocol?
    
    func attach(view: FavoriteListViewProtocol) {
        self.view = view
    }
    
    func unFavorite(movieId: Int) {
        DBManager.sharedInstance.deleteMovie(movieId: movieId)
        self.loadFavoriteMovies()
    }
    
    func loadFavoriteMovies() {
        let movies: [MovieData] = DBManager.sharedInstance.getDataFromDB().map {
            return $0.toMovieData()
        }
        
        self.view?.onLoadedFavoriteMovies(movies: movies)
    }
    
    func filter(text: String) {
        let movies: [MovieData] = DBManager.sharedInstance.getDataFromDB().map {
            return $0.toMovieData()
        }
        
        let filterMovies = movies.filter({ movie -> Bool in
            if text.count > 0 {
                return movie.originalTitle.localizedCaseInsensitiveContains(text)
            } else {
                return true
            }
        })
        
        self.view?.onFilterResult(movies: filterMovies)
        if filterMovies.count == 0 {
            self.view?.onFilterEmptyResult()
        }
    }
}
