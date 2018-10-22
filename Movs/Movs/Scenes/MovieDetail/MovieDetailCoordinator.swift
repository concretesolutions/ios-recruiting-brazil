//
//  MovieDetailCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    func start() {
        let vc = MovieDetailViewController()
        vc.presenter = MovieDetailPresenter(view: vc, coordinator: self)
    }
}
