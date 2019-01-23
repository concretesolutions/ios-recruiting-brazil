//
//  PopularMoviesCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class PopularMoviesCoordinator {
    func create() -> UIViewController {
        let viewController = PopularMoviesViewController()
        let provider = TheMovieDBProvider()

        _ = MovieListViewModel(view: viewController, dataProvider: provider)

        return viewController
    }
}
