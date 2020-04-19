//
//  MovieDetailCoordinator.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        if let viewController = storyboard.instantiateInitialViewController() as? MovieDetailViewController {
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
