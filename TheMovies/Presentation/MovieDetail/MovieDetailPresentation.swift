//
//  MovieDetailPresentation.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import Swinject

final class MovieDetailPresentation {
    
    private(set) var controller: MovieDetailsController
    
    init(controller: MovieDetailsController) {
        self.controller = controller
    }
    
    /// Factory responsável pela instanciação e configuração do módulo de apresentação
    ///
    /// - Parameter resolver: Objeto de auxilio para obtenção de dependencias
    /// - Returns: Instancia do módulo de apresentação
    static func build(with resolver: Resolver) -> MovieDetailPresentation{
        
        guard let memoryRepository = resolver.resolve(MovieMemoryRepositoryProtocol.self) else {
            fatalError("It's necessary initialize the MovieMemoryRepositoryProtocol on AppDelegate+DISetup")
        }
        
        let loadMovieDetailUseCase = LoadMovieDetailUseCase(memoryRepository: memoryRepository)
        let favoriteMovieUseCase = ToogleFavoriteMovieStateUseCase(memoryRepository: memoryRepository)
        
        let presenter = MovieDetailsPresenter(loadMovieDetailUseCase: loadMovieDetailUseCase,
                                              favoriteMovieUseCase: favoriteMovieUseCase)
        
        let controller = MovieDetailsController(presenter: presenter)
        
        return .init(controller: controller)
    }
}

