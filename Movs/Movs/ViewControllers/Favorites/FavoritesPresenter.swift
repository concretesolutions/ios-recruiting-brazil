//
//  FavoritesPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

protocol FavoritesView: AnyObject {
    func openMovieDetails()
}

class FavoritesPresenter {
    weak var view: FavoritesView?

    func onMovieSelected() {
        view?.openMovieDetails()
    }
}
