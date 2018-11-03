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
        guard let movie = self.data as? Movie else { return }
        let vc = MovieDetailViewController()
        let presenter = MovieDetailPresenter(view: vc, coordinator: self)
        presenter.initialData = movie
        vc.presenter = presenter
        self.onCoordinatorStarted?(vc)
    }
}
