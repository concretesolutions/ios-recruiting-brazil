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
    
    private lazy var operation = FetchMovieDetailOperation(movieId: self.initialData.id)
    
    var initialData:Movie! {
        didSet {
            self.operation.onSuccess = { [weak self] detail in
                self?.view?.present(movieDetail: detail)
            }
            self.operation.perform()
        }
    }
    
    var view:MovieDetailPresenterView? {
        return self.baseView as? MovieDetailPresenterView
    }
}

extension MovieDetailPresenter: MovieDetailViewPresenter {
    
    func didFavoriteMovie() {
        
    }
    
    func didUnfavoriteMovie() {
        
    }
}
