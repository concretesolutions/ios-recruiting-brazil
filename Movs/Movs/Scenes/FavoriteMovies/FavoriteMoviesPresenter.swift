//
//  FavoriteMoviesPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol FavoriteMoviesPresenterView: ViewProtocol {
}

final class FavoriteMoviesPresenter: MVPBasePresenter {
    
    var view:MovieDetailPresenterView? {
        return self.baseView as? MovieDetailPresenterView
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesViewPresenter {
}
