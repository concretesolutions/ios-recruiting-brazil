//
//  MoviesGridPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol MoviesGridPresenterView: ViewProtocol {
}

final class MoviesGridPresenter: MVPBasePresenter {
    
    var view:MoviesGridPresenterView? {
        return self.baseView as? MoviesGridPresenterView
    }
}

extension MoviesGridPresenter: MoviesGridViewPresenter {
}
