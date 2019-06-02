//
//  MovieListPresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct MovieListViewData {
    var currentPage = 1
    var totalPages = 1
    var movies = [MovieElement]()
}

struct MovieElement {
    var title = ""
    var releaseDate = ""
    var rating = 0.0
    var urlImage = ""
}

//MARK: - VIEW DELEGATE -
protocol MovieListViewDelegate: NSObjectProtocol {
    func showLoading()
    func hideLoading()
    func showError()
    func showEmptyList()
    func setViewData(viewData: MovieListViewData)
}

//MARK: - PRESENTER CLASS -
class MovieListPresenter {
    
    private weak var viewDelegate: MovieListViewDelegate?
    private lazy var viewData = MovieListViewData()
    private var service: MovieService!
    
    init(viewDelegate: MovieListViewDelegate) {
        self.viewDelegate = viewDelegate
        self.service = MovieService()
    }
}

//SERVICE
extension MovieListPresenter {
    func getPopularMovies() {
        self.viewDelegate?.showLoading()
        if !Reachability.isConnectedToNetwork() {
            self.viewDelegate?.hideLoading()
            self.viewDelegate?.showError()
            return
        }
        self.service.getPopularMovies(page: 1) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieList):
                    self.parseModelFromViewData(model: movieList)
                    if self.viewData.movies.count > 0 {
                        self.viewDelegate?.setViewData(viewData: self.viewData)
                    }else {
                        self.viewDelegate?.showEmptyList()
                    }
                    break
                case .failure(_):
                    self.viewDelegate?.showError()
                    break
                }
                self.viewDelegate?.hideLoading()
            }
        }
    }
}

//AUX METHODS
extension MovieListPresenter {
    private func parseModelFromViewData(model: MovieModel) {
        self.viewData.movies.removeAll()
        self.viewData.currentPage = model.page ?? 1
        self.viewData.totalPages = model.totalPages ?? 1
        if let results = model.results, results.count > 0 {
            results.forEach({self.parseModelElementFromViewData(resultModel: $0)})
        }
    }
    
    private func parseModelElementFromViewData(resultModel: Results) {
        var element = MovieElement()
        element.title = resultModel.title ?? ""
        element.releaseDate = resultModel.releaseDate ?? ""
        element.rating = resultModel.voteAverage ?? 0.0
        if let posterPath = resultModel.posterPath {
            element.urlImage = "https://image.tmdb.org/t/p/w300\(posterPath)"
        }
        self.viewData.movies.append(element)
    }
}

//DATABASE
extension MovieListPresenter {
    
}
