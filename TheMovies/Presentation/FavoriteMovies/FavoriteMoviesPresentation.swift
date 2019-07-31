//
//  FavoriteMoviesPresentation.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Swinject

final class FavoriteMoviesPresentation {
    
    private(set) var controller: FavoriteMoviesNavigationController
    
    init(controller: FavoriteMoviesNavigationController) {
        self.controller = controller
    }
    
    /// Factory responsável pela instanciação e configuração do módulo de apresentação
    ///
    /// - Parameter resolver: Objeto de auxilio para obtenção de dependencias
    /// - Returns: Instancia do módulo de apresentação
    static func build(with resolver: Resolver) -> FavoriteMoviesPresentation{
        
        guard let memoryRepository = resolver.resolve(MovieMemoryRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the MovieMemoryRepositoryProtocol on AppDelegate+DISetup")
        }
        
        guard let genreMemoryRepository = resolver.resolve(GenreMemoryRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the MovieMemoryRepositoryProtocol on AppDelegate+DISetup")
        }
        
        let navigationController = FavoriteMoviesNavigationController()

        let loadFavoriteMoviesUseCase = LoadFavoriteMoviesUseCase(memoryRepository: memoryRepository)
        let favoriteMovieUseCase = ToogleFavoriteMovieStateUseCase(memoryRepository: memoryRepository)
        let loadMoviesYearUseCase = LoadMoviesYearUseCase(memoryRepository: memoryRepository)
        let loadGenresFromCacheUseCase = LoadGenresFromCacheUseCase(memoryRepository: genreMemoryRepository)
        
        let presenter = FavoriteMoviesPresenter(loadFavoriteMoviesUseCase: loadFavoriteMoviesUseCase, favoriteMovieUseCase: favoriteMovieUseCase, loadMoviesYearUseCase: loadMoviesYearUseCase, loadGenresFromCacheUseCase: loadGenresFromCacheUseCase)
        
        let favoriteController = FavoriteMoviesController(presenter: presenter)
        
        navigationController.viewControllers = [favoriteController]
        
        return .init(controller: navigationController)
    }
}
