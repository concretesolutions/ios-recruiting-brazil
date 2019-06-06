//
//  MovieDetailPresenter.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct TempMovieDetailViewData {
    
}

//MARK: - VIEW DELEGATE -
protocol MovieDetailViewDelegate: NSObjectProtocol {
    
}

//MARK: - PRESENTER CLASS -
class MovieDetailPresenter {
    
    private weak var viewDelegate: MovieDetailViewDelegate?
    private lazy var viewData = TempMovieDetailViewData()
    
    init(viewDelegate: MovieDetailViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

//SERVICE
extension MovieDetailPresenter {
    public func addMovieFavorite(movieViewData: MovieElementViewData) {
        let model = self.parseViewDataFromModel(movieViewData: movieViewData)
        MovieDataBase().createOrRemoveMovieDataBase(model: model)
    }
    
   
 
}

//AUX METHODS
extension MovieDetailPresenter {
    private func parseViewDataFromModel(movieViewData: MovieElementViewData) -> MovieElementModel {
        let model = MovieElementModel()
        model.id = movieViewData.id
        model.title = movieViewData.title
        model.backdropPath = movieViewData.detail.urlImagePost
        model.posterPath = movieViewData.urlImageCover
        model.overview = movieViewData.detail.description
        model.voteAverage = movieViewData.detail.rating
        model.releaseDate = movieViewData.detail.releaseDate
        return model
    }
}

//DATABASE
extension MovieDetailPresenter {
    
}
