//
//  ShowMovieDetailsUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import Swinject
import RxSwift

/// Mostra a cena de detalhes de um filme
final class ShowMovieDetailsUserCase: UseCase<Int, Bool> {
    
    private var resolver: Resolver
    private var navController: UINavigationController
    
    init(navController: UINavigationController, resolver: Resolver) {
        self.resolver = resolver
        self.navController = navController
    }
    
    override func run(_ params: Int...){
        
        guard let id = params.first else {
            fatalError("This use case needs the parameter id(Int)")
        }
        
        let movieDetailModule = MovieDetailPresentation.build(with: resolver)
        movieDetailModule.controller.id = id
        self.navController.pushViewController(movieDetailModule.controller, animated: false)
        
        self.resultPublisher.onNext(true)
    }
}
