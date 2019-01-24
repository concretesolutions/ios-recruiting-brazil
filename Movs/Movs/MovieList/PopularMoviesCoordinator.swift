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

        navVc.navigationBar.barTintColor = .movsYellow

        _ = MovieListViewModel(view: viewController, dataProvider: provider)

        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: #imageLiteral(resourceName: "list_icon"), selectedImage: nil)

        return navVc
    }
}
