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
    var favoritesVC: FavoritesViewController?

    init(vc: FavoritesViewController) {
        favoritesVC = vc
    }
    
    func getFavorites() {
        //TODO:
    }
    
}
