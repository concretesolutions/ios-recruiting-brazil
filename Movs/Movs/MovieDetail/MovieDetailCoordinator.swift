//
//  MovieDetailCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class MovieDetailCoordinator {
    let config: MovsConfig

    init(config: MovsConfig) {
        self.config = config
    }

    func create(with movie: Movie) -> UIViewController {
        let viewModel = MovieDetailViewModel(movie: movie, config: config)
        let detailVc = MovieDetailViewController()
        detailVc.hidesBottomBarWhenPushed = true
        detailVc.viewModel = viewModel
        
        return detailVc
    }
}
