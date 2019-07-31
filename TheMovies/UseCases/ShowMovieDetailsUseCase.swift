//
//  ShowMovieDetailsUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import Swinject

/// Mostra a cena de detalhes de um filme
final class ShowMovieDetailsUserCase {
    
    private var resolver: Resolver
    private var navController: UINavigationController
    
    init(navController: UINavigationController, resolver: Resolver) {
        self.resolver = resolver
        self.navController = navController
    }
    
    func run(with id: Int) {
        let movieDetailModule = MovieDetailPresentation.build(with: resolver)
        movieDetailModule.controller.id = id
        self.navController.pushViewController(movieDetailModule.controller, animated: false)
    }
}
