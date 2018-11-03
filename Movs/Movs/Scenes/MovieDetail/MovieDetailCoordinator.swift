//
//  MovieDetailCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    var data: Any?
    var onCoordinatorStarted: OnCoordinatorStarted?
    
    func start() {
        let vc = MovieDetailViewController()
        vc.presenter = MovieDetailPresenter(view: vc, coordinator: self)
        self.onCoordinatorStarted?(vc)
    }
}
