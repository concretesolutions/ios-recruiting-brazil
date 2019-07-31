//
//  RootTabBarPresentation.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import Swinject

final class RootTabBarPresentation {
    
    // Controller raiz do modulo de apresentação
    private(set) var controller: UIViewController
    
    private init(controller: UIViewController) {
        self.controller = controller
    }
    
    /**
     * Factory responsável pela instanciação e configuração do módulo
     */
    static func build(with resolver: Resolver) -> RootTabBarPresentation{
        
        guard let moviesGridPresentation = resolver.resolve(MoviesGridPresentation.self) else {
            fatalError(":: Dependency not found :: MoviesGridPresentation")
        }
        
        guard let favoriteMoviesPresentation = resolver.resolve(FavoriteMoviesPresentation.self) else {
            fatalError(":: Dependency not found :: FavoriteMoviesPresentation")
        }
        
        let controller = RootTabBarController(items: [ moviesGridPresentation.controller, favoriteMoviesPresentation.controller])
        
        return .init(controller: controller)
    }
}
