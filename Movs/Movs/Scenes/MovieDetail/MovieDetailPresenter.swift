//
//  MovieDetailPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterView: ViewProtocol {
    func present(movieDetail:MovieDetail)
}

final class MovieDetailPresenter: MVPBasePresenter {
    
    private let favoritesDAO = try! FavoriesDAO()
    private lazy var operation = FetchMovieDetailOperation(movieId: self.initialData.id)
    
    var initialData:Movie! {
        didSet {
            self.operation.onSuccess = { [weak self] detail in
                self?.movieDetail = detail
            }
            self.operation.perform()
        }
    }
    
    private(set) var movieDetail:MovieDetail! {
        didSet {
            self.view?.present(movieDetail: self.movieDetail)
        }
    }
    
    var view:MovieDetailPresenterView? {
        return self.baseView as? MovieDetailPresenterView
    }
}

extension MovieDetailPresenter: MovieDetailViewPresenter {
    
    func didFavoriteMovie() {
        do {
            try self.favoritesDAO.add(favoriteMovie: self.movieDetail)
        } catch {}
    }
    
    func didUnfavoriteMovie() {
        do {
            try self.favoritesDAO.remove(favoriteMovie: self.movieDetail)
        } catch {}
    }
}
