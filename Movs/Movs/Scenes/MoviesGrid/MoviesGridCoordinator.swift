//
//  MoviesGridCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MoviesGridCoordinator: Coordinator {
    
    var onCoordinatorStarted: OnCoordinatorStarted?
    
    func start() {
        let vc = MoviesGridViewController()
        vc.presenter = MoviesGridPresenter(view: vc, coordinator: self)
        self.onCoordinatorStarted?(vc)
    }
}
