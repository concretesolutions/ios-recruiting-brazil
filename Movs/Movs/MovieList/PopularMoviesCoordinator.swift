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
        let navVc = UINavigationController(rootViewController: viewController)
        navVc.navigationBar.barTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        _ = MovieListViewModel(view: viewController, dataProvider: provider)

        return navVc
    }
}
