//
//  FavoritePresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

enum RatingMovie: String {
    case upToFiveStars = "De 4.0 a 5.0 estrelas"
    case upToFourStars = "De 3.0 a 4.0 estrelas"
    case upToThreeStars = "Até 3.0 estrelas"
    case none = "Sem avaliação"
}

//MARK: - STRUCT VIEW DATA -
struct FavoriteViewData {
    var favoritesMovies = [RatingViewData]()
}

struct RatingViewData {
    var labelRating = RatingMovie.none.rawValue
    var movies = [MovieElementViewData]()
}

//MARK: - VIEW DELEGATE -
protocol FavoriteViewDelegate: NSObjectProtocol {
    func setViewData(viewData: FavoriteViewData)
}

//MARK: - PRESENTER CLASS -
class FavoritePresenter {
    
    private weak var viewDelegate: FavoriteViewDelegate?
    private lazy var viewData = FavoriteViewData()
    private var dataBase: GenreDataBase!
    private var genreViewDataList = [GenreViewData]()
    
    init(viewDelegate: FavoriteViewDelegate) {
        self.viewDelegate = viewDelegate
        self.dataBase = GenreDataBase()
    }
}

//MARK: - SERVICE -
extension FavoritePresenter {
    
    func getFavoriteMovies() {
        if let movies = self.getFavoriteMoviesInDB(), movies.count > 0 {
            self.parseModelFromViewData(modelElementList: movies)
            self.viewDelegate?.setViewData(viewData: self.viewData)
        }else {
            // emptyList
        }
        
    }
    
}

//MARK: - UX METHODS -
extension FavoritePresenter {
    
    private func parseModelFromViewData(modelElementList: [MovieElementModel]) {
        self.viewData.favoritesMovies.removeAll()
        let options: [RatingMovie] = [.upToFiveStars, .upToFourStars, .upToThreeStars, .none]
        options.forEach { (optionRow) in
            let resultFilter = self.filterStars(modelElementList: modelElementList, typeFilter: optionRow)
            if resultFilter.count > 0 {
                var ratingViewData = RatingViewData()
                ratingViewData.labelRating = optionRow.rawValue
                resultFilter.forEach({ (movieElementRow) in
                    ratingViewData.movies.append(self.parseElementModelFromViewData(resultModel: movieElementRow))
                })
                self.viewData.favoritesMovies.append(ratingViewData)
            }
        }
    }
    
    private func parseElementModelFromViewData(resultModel: MovieElementModel) -> MovieElementViewData {
        var element = MovieElementViewData()
        element.id = resultModel.id ?? 0
        element.title = resultModel.title ?? ""
        element.detail.releaseDate = resultModel.releaseDate ?? ""
        if let rating = resultModel.voteAverage {
            element.detail.rating = rating / 2
        }
        if let coverPath = resultModel.posterPath {
            element.urlImageCover = coverPath
        }
        if let posterPath = resultModel.backdropPath {
            element.detail.urlImagePost = posterPath
        }
        element.detail.description = resultModel.overview ?? ""
        
        if let genreModelList = resultModel.genreModel?.genres, genreModelList.count > 0 {
            genreModelList.forEach { (genreRow) in
                element.detail.genres.append(self.parseGenreModelFromViewData(genreModel: genreRow))
            }
        }
        element.detail.isFavorited = true
        return element
    }
    
    private func parseGenreModelFromViewData(genreModel: Genres) -> GenreViewData {
        return GenreViewData(id: genreModel.id ?? 0, name: genreModel.name ?? "")
    }
    
    private func filterStars(modelElementList: [MovieElementModel], typeFilter: RatingMovie) -> [MovieElementModel] {
        var valueFilterMax: Double
        var valueFilterMin: Double
        switch typeFilter {
        case .upToFiveStars:
            valueFilterMax = 5.0
            valueFilterMin = 4.0
            break
        case .upToFourStars:
            valueFilterMax = 3.9
            valueFilterMin = 3.0
            break
        case .upToThreeStars:
            valueFilterMax = 2.9
            valueFilterMin = 0.1
            break
        default:
            valueFilterMax = 0.0
            valueFilterMin = 0.0
        }
        return modelElementList.filter({$0.voteAverage ?? 0 >= valueFilterMin && $0.voteAverage ?? 0 <= valueFilterMax})
    }
}

//MARK: - DATABASE -
extension FavoritePresenter {
    
    private func getFavoriteMoviesInDB() -> [MovieElementModel]? {
        return MovieDataBase().fetchMoviesDataBase()
    }
    
    private func getGenresDataBase() -> GenreModel {
        return GenreDataBase().fetchMoviesDataBase() ?? GenreModel()
    }
    
}
