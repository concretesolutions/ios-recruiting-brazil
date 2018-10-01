//
//  MoviesPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

protocol MoviesView: AnyObject {
    func openMovieDetails()
}

class MoviesPresenter {

    weak var view: MoviesView?

    func onMovieSelected() {
        view?.openMovieDetails()
    }
}
