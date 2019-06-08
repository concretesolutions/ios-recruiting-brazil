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
    var movies = [MovieElementViewData]()
}

struct MovieElementViewData {
    var id: Int64 = 0
    var title = ""
    var urlImageCover = ""
    var detail = MovieDetailViewData()
}

struct MovieDetailViewData {
    var releaseDate = ""
    var rating = 0.0
    var urlImagePost = ""
    var description = ""
    var isFavorited = false
    var genres = [GenreViewData]()
}

struct GenreViewData {
    var id: Int64 = 0
    var name = ""
}

//MARK: - VIEW DELEGATE -
protocol MovieListViewDelegate: NSObjectProtocol {
    func showLoading()
    func showError()
    func showEmptyList()
    func setViewData(viewData: MovieListViewData)
    func setViewDataOfNextPage(viewData: MovieListViewData)
}

//MARK: - PRESENTER CLASS -
class MovieListPresenter {
    
    private weak var viewDelegate: MovieListViewDelegate?
    private lazy var viewData = MovieListViewData()
    private var service: MovieService!
    private var genreViewDataList = [GenreViewData]()
    private var favoriteMovies: [MovieElementModel]!
    
    init(viewDelegate: MovieListViewDelegate) {
        self.viewDelegate = viewDelegate
        self.service = MovieService()
    }
}

//MARK: - METHODS PUBLICS -
extension MovieListPresenter {
    public func callServices() {
        self.genreViewDataList.removeAll()
        self.viewData.movies.removeAll()
        self.viewDelegate?.showLoading()
        if !Reachability.isConnectedToNetwork() {
            self.viewDelegate?.showError()
            return
        }
        self.getGenres {
            self.getInitialPopularMovies()
        }
    }
    
    public func getMovies(for page: Int) {
        self.genreViewDataList.removeAll()
        self.viewData.movies.removeAll()
        if !Reachability.isConnectedToNetwork() {
            self.viewDelegate?.showError()
            return
        }
        self.getMovieOfPage(pageNumber: page)
    }
}

//MARK: - SERVICE -
extension MovieListPresenter {
    private func getInitialPopularMovies() {
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
            }
        }
    }
    
    private func getMovieOfPage(pageNumber: Int) {
        self.service.getPopularMovies(page: pageNumber) { (result) in
            switch result {
            case .success(let movieList):
                self.parseModelFromViewData(model: movieList)
                if self.viewData.movies.count > 0 {
                    self.viewDelegate?.setViewDataOfNextPage(viewData: self.viewData)
                }
                break
            default:
                break
            }
        }
    }
    
    private func getGenres(completion: @escaping () -> Void) {
        self.service.getGenre { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let genreModel):
                    self.parseGenreModelFromViewData(model: genreModel)
                    self.createGenreDataBase(model: genreModel)
                    break
                case .failure(_):
                    let genreModelDB = self.getGenresDataBase()
                    self.parseGenreModelFromViewData(model: genreModelDB)
                    break
                }
                completion()
                return
            }
        }
    }
}

//AUX METHODS
extension MovieListPresenter {
    private func parseModelFromViewData(model: MovieModel) {
        self.viewData.currentPage = model.page ?? 1
        self.viewData.totalPages = model.totalPages ?? 1
        if let results = model.results, results.count > 0 {
            results.forEach({self.parseModelElementFromViewData(resultModel: $0)})
        }
    }
    
    private func parseModelElementFromViewData(resultModel: MovieElementModel) {
        var element = MovieElementViewData()
        element.id = resultModel.id ?? 0
        element.title = resultModel.title ?? ""
        element.detail.releaseDate = resultModel.releaseDate ?? ""
        if let rating = resultModel.voteAverage {
            element.detail.rating = rating / 2
        }
        if let coverPath = resultModel.posterPath {
            element.urlImageCover = "https://image.tmdb.org/t/p/w500\(coverPath)"
        }
        if let posterPath = resultModel.backdropPath {
            element.detail.urlImagePost = "https://image.tmdb.org/t/p/w500\(posterPath)"
        }
        element.detail.description = resultModel.overview ?? ""
        if let genreIdList = resultModel.genreIds, genreIdList.count > 0 {
            genreIdList.forEach { (genreIdRow) in
                if let genreViewData = self.getGenreViewDataById(id: genreIdRow) {
                     element.detail.genres.append(genreViewData)
                }
            }
        }
        element.detail.isFavorited = self.getFavoriteStatus(idMovie: element.id)
        self.viewData.movies.append(element)
    }
    
    private func parseGenreModelFromViewData(model: GenreModel) {
        if let genreList = model.genres, genreList.count > 0 {
            genreList.forEach { (genreRow) in
                let genreViewData = GenreViewData(id: genreRow.id ?? 0, name: genreRow.name ?? "")
                self.genreViewDataList.append(genreViewData)
            }
        }
    }
    
    private func getGenreViewDataById(id: Int64) -> GenreViewData? {
        return self.genreViewDataList.filter({$0.id == id}).first
    }
}

//DATABASE
extension MovieListPresenter {
    
    private func createGenreDataBase(model: GenreModel) {
        GenreDataBase().createOrUpdateGenreDataBase(model: model)
    }
    
    private func getGenresDataBase() -> GenreModel {
        return GenreDataBase().fetchMoviesDataBase() ?? GenreModel()
    }
    
    private func getFavoriteStatus(idMovie: Int64) -> Bool {
        return MovieDataBase().isFavoriteMovie(idMovie: idMovie)
    }
}
