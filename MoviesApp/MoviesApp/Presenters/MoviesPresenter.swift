//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

protocol MoviesViewProtocol: NSObjectProtocol {
    func startLoading()
    func endLoading()
    func startNewPageLoading()
    func endNewPageLoading()
    func set(movies: [Movie])
    func add(page: [Movie])
    func show(error: Error)
}

class MoviesPresenter {
    private let service = MoviesService()
    private weak var view: MoviesViewProtocol?
    private var pagination = Pagination()
    
    func atttach(_ presentedView: MoviesViewProtocol) {
        self.view = presentedView
    }
    
    func loadData() {
        view?.startLoading()
        if GenrePersistanceHelper.getGenre().isEmpty {
            service.loadGenres { (_error) in
                if let error = _error {
                    self.view?.endLoading()
                    self.view?.show(error: error)
                } else {
                    self.loadMovies()
                }
            }
        } else {
            loadMovies()
        }
    }
    
    private func loadMovies() {
        service.loadPopular { (movies, _pagination, _error) in
            self.view?.endLoading()
            if let error = _error {
                self.view?.show(error: error)
            } else {
                if let newPagination  = _pagination {
                    self.pagination = newPagination
                } else {
                    self.pagination = Pagination()
                }
                self.view?.set(movies: movies)
            }
        }
    }
    
    func loadNextPage() {
        if pagination.hasNext {
            self.view?.startNewPageLoading()
            service.loadPopular(page: pagination.nextPage) { (movies, _pagination, _error) in
                self.view?.endNewPageLoading()
                if let error = _error {
                    self.view?.show(error: error)
                } else {
                    if let newPagination  = _pagination {
                        self.pagination = newPagination
                    } else {
                        self.pagination = Pagination()
                    }
                    self.view?.add(page: movies)
                }
            }
        }
    }
    
    func favorite(movie: Movie) {
        FavoriteHelper.setFavorite(movie: movie)
    }
    
    func unfavorite(movie: Movie) {
        FavoriteHelper.unfavorite(movie: movie)
    }
}
