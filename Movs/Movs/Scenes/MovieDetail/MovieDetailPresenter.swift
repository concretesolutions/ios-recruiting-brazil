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
    private var operation: FetchMovieDetailOperation!
    
    var initialData:Movie?
    
    var movieDetail:MovieDetail!
    
    var validMovieId:Int {
        var id:Int
        if let initialData = self.initialData {
            id = initialData.id
        } else {
            id = self.movieDetail.id
        }
        return id
    }
    
    var view:MovieDetailPresenterView? {
        return self.baseView as? MovieDetailPresenterView
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if let _ = self.initialData {
            self.fetchMovieDetail()
        } else {
            self.setupMovieDetail()
        }
    }
    
    func setupMovieDetail() {
        if self.movieDetail.isComplete {
            self.view?.present(movieDetail: self.movieDetail)
        } else {
            self.fetchMovieDetail(forCompletingObject: true)
        }
    }
    
    func fetchMovieDetail(forCompletingObject:Bool = false) {
        self.operation = FetchMovieDetailOperation(movieId: self.validMovieId)
        self.operation.onSuccess = { [weak self] detail in
            self?.movieDetail = detail
            self?.setupMovieDetail()
            if forCompletingObject {
                do {
                    try self?.favoritesDAO.add(favoriteMovie: detail)
                } catch {}
            }
        }
        self.operation.perform()
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
