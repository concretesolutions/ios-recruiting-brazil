//
//  MovieDetailCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    var childs: [Coordinator] = []
    var data: Any?
    var onCoordinatorStarted: OnCoordinatorStarted?
    
    func start() {
        
        let vc = MovieDetailViewController()
        let presenter = MovieDetailPresenter(view: vc, coordinator: self)
        
        switch self.data {
        case let mov as Movie:
            presenter.initialData = mov
        case let mov as MovieDetail:
            presenter.movieDetail = mov
        default:
            break
        }
        
        vc.presenter = presenter
        self.onCoordinatorStarted?(vc)
    }
}
