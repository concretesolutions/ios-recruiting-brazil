//
//  FavoriteMoviesCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FavoriteMoviesCoordinator: Coordinator {
    
    var data: Any?
    var onCoordinatorStarted: OnCoordinatorStarted?
    
    func start() {
        let vc = FavoriteMoviesViewController()
        vc.presenter = FavoriteMoviesPresenter(view: vc, coordinator: self)
        self.onCoordinatorStarted?(vc)
    }
}
