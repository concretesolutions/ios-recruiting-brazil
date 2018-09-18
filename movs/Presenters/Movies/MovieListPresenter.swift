//
//  MovieListPresenter.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

struct MovieData {
    let id: Int
    let originalTitle: String
    let posterPath: String
    let genres: [GenreData]
    let overview: String
    let releaseData: String
}

struct GenreData {
    let id: Int
    var name: String
}

protocol MovieListViewProtocol: NSObjectProtocol {
    func showProgress(show: Bool)
    func showError(error: NSError)
    func onLoadedMovieList(entries: [MovieData])
    func onLoadedMovieDetail(entry: MovieData)
    func endPagination()
}

class MovieListPresenter {
    private let service = MoviesService()
    private var pagination = Pagination()
    private var movies: [MovieData] = []
    
    weak var view: MovieListViewProtocol?
    
    init() {
        self.pagination = Pagination()
    }
    
    func attach(view: MovieListViewProtocol) {
        self.view = view
    }
    
    func loadMovieList() {
        self.view?.showProgress(show: true)
        self.service.moviePopular(page: self.pagination.currentPage) { [weak self] (result, error, meta) in
            self?.view?.showProgress(show: false)
            if let error = error {
                self?.view?.showError(error: error)
                return
            }
            
            if let meta = meta {
                self?.pagination.currentPage = meta.page
                self?.pagination.totalPages = meta.totalPages
            }
            
            let entries = result.map {
                return $0.toMovieData()
            }
            self?.movies.append(contentsOf: entries)
            
            self?.view?.onLoadedMovieList(entries: entries)
        }
    }

    func loadMoreMovieList() {
        if self.pagination.nextPage() {
            self.pagination.currentPage += 1
            self.loadMovieList()
        } else {
            self.view?.endPagination()
        }
    }
    
    func loadMovieDetail(movieData: MovieData) {
        self.view?.showProgress(show: true)
        self.service.movieDetail(movieId: movieData.id, completion: { [weak self] (result, error, meta) in
            self?.view?.showProgress(show: false)
            if let error = error {
                self?.view?.showError(error: error)
                return
            }
            
            if let movie = result {
                self?.view?.onLoadedMovieDetail(entry: movie.toMovieData())
            }
        })
    }
}
