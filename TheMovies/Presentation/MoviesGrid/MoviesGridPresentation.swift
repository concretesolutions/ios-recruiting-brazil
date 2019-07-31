//
//  MoviesGridModule.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import Swinject

final class MoviesGridPresentation {
    
    // Controller raiz do modulo de apresentação
    private(set) var controller: MoviesGridNavigationController
    
    init(controller: MoviesGridNavigationController) {
        self.controller = controller
    }
    
    /// Factory responsável pela instanciação e configuração do módulo  de apresentação
    ///
    /// - Parameter resolver: Objeto de auxilio para obtenção de dependencias
    /// - Returns: Instancia do módulo de apresentação
    static func build(with container: Container) -> MoviesGridPresentation{
        
        guard let movieMemoryRepository = container.resolve(MovieMemoryRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the MovieMemoryRepositoryProtocol on AppDelegate+DISetup")
        }
        
        guard let movieNetworkRepository = container.resolve(MovieNetworkRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the MovieMemoryRepositoryProtocol on AppDelegate+DISetup")
        }
        
        guard let genreMemoryRepository = container.resolve(GenreMemoryRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the GenreMemoryRepositoryProtocol on AppDelegate+DISetup")
        }
        
        guard let genreNetworkRepository = container.resolve(GenreNetworkRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the GenreNetworkRepositoryProtocol on AppDelegate+DISetup")
        }
        
        let navigationController = MoviesGridNavigationController()
        
        let convertMovieEntityToModelUseCase = ConvertMovieEntityToModelUseCase(genreMemoryRepository: genreMemoryRepository)
        
        let loadMoviesUseCase = LoadMoviesFromNetworkAndCacheUseCase(memoryRepository: movieMemoryRepository,
                                                  networkRepository: movieNetworkRepository, convertMovieEntityToModelUseCase: convertMovieEntityToModelUseCase)
        
        let showMovieDetailsUseCase = ShowMovieDetailsUserCase(navController: navigationController,
                                                              resolver: container)
        
        let loadGenresAndCacheUseCase = LoadGenresAndCacheUseCase(memoryRepository: genreMemoryRepository,
                                                                  networkRepository: genreNetworkRepository)
        
        let loadMoviesFromCacheUseCase = LoadMoviesFromCacheUseCase(memoryRepository: movieMemoryRepository)
        
        let presenter = MoviesGridPresenter(loadMoviesUseCase: loadMoviesUseCase,
                                            showMovieDetailsUseCase: showMovieDetailsUseCase,
                                            loadGenresAndCacheUseCase: loadGenresAndCacheUseCase,
                                            loadMoviesFromCacheUseCase: loadMoviesFromCacheUseCase)

        let controller = MoviesGridController(presenter: presenter)
        
        navigationController.pushViewController(controller, animated: false)
        
        return .init(controller: navigationController)
    }
}
