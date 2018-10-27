//
//  MovieDetailPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterView: ViewProtocol {
}

final class MovieDetailPresenter: MVPBasePresenter {
    
    var view:MovieDetailPresenterView? {
        return self.baseView as? MovieDetailPresenterView
    }
}

extension MovieDetailPresenter: MovieDetailViewPresenter {
}
