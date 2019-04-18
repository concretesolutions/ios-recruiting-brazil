//
//  FavoritesPresenter.swift
//  movs
//
//  Created by Lorien Moisyn on 17/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FavoritesPresenter {
    
    var favorites: [Movie] = []
    var moviesVC: MoviesViewController?

    init(vc: MoviesViewController) {
        moviesVC = vc
    }
    
    func getFavorites() {
        //TODO:
    }
    
    func markAsFavorite(_ movie: Movie) {
        //TODO:
    }
    
    func unfavorite(_ movie: Movie) {
        //TODO:
    }
    
}
