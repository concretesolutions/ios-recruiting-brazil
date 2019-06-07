//
//  HomePresenter.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import Foundation

// MARK: - STRUCT VIEW DATA -
struct HomeViewData {
    var currentPage = 1
    var totalPages = 0
    var movies = [MovieViewData]()
}

struct MovieViewData: Codable {
    var movieId = 0
    var posterURL = ""
    var backdropURL = ""
    var title = ""
    var releaseDate = ""
    var overview = ""
    var isFavorite = false
    var genreIds = [Int]()
}

// MARK: - VIEW DELEGATE -
protocol HomeViewDelegate: NSObjectProtocol {
    func setLoadingMovies(_ loading: Bool)
    func showMovies(viewData: HomeViewData)
    func showError()
}

// MARK: - PRESENTER CLASS -
class HomePresenter {
    
    private weak var viewDelegate: HomeViewDelegate?
    private var viewData = HomeViewData()
    private lazy var service = MoviesService()
    
    init(viewDelegate: HomeViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

// MARK: - SERVICE -
extension HomePresenter {
    func getMovies(page: Int, reload: Bool) {
        if reload { self.viewData = HomeViewData()}
        self.viewDelegate?.setLoadingMovies(true)
        self.service.getMovies(page: page, errorCompletion: { [unowned self] (_) in
            self.viewDelegate?.showError()
        }, successCompletion: { [unowned self] (moviesResult) in
            self.createHomeViewData(moviesResult: moviesResult)
            self.viewDelegate?.showMovies(viewData: self.viewData)
        })
    }
}

// MARK: - AUX METHODS -
extension HomePresenter {
    private func createHomeViewData(moviesResult: MoviesResult) {
        guard let results = moviesResult.results,
            let totalPages = moviesResult.totalPages else { self.viewDelegate?.showError(); return }
        self.viewData.currentPage += 1
        self.viewData.totalPages = totalPages
        for movie in results {
            var movieViewData = MovieViewData()
            if let posterPath = movie.posterPath {
                movieViewData.posterURL = Constants.Hosts.moviePoster + posterPath
            }
            if let backdropPath = movie.backdropPath {
                movieViewData.backdropURL = Constants.Hosts.movieBackdrop + backdropPath
            }
            if let title = movie.title {
                movieViewData.title = title
            }
            if let releaseDate = movie.releaseDate,
                let date = self.stringToDate(date: releaseDate) {
                movieViewData.releaseDate = self.dateToFormattedString(date: date)
            }
            if let overview = movie.overview {
                movieViewData.overview = overview
            }
            if let movieId = movie.movieId {
                movieViewData.movieId = movieId
            }
            if let result: [MovieViewData] = UserDefaulstHelper.shared.getObject(forKey: Constants.UserDefaultsKey.favoriteList),
                !result.filter({$0.movieId == movie.movieId}).isEmpty {
                movieViewData.isFavorite = true
            }
            if let genres = movie.genreIds {
                movieViewData.genreIds = genres.compactMap({$0})
            }
            self.viewData.movies.append(movieViewData)
        }
    }
    
    private func stringToDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else { return nil }
        return date
    }
    
    private func dateToFormattedString(date: Date) -> String {
        let locale = Locale(identifier: "pt-BR")
        let dateFormatter = DateFormatter()
        guard let dayFormat = DateFormatter.dateFormat(fromTemplate: "d MMMM yyyy", options: 0, locale: locale) else {
            return ""
        }
        dateFormatter.dateFormat = dayFormat
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
    }
}
