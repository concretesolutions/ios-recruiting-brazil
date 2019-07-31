//
//  LoadFavoriteMoviesUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Este caso de uso carrega todos os filmes favoritados da memória
class LoadFavoriteMoviesUseCase: UseCase<[Movie], [Movie]> {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        self.memoryRepository = memoryRepository
    }
    
    override func run(_ params: [Movie]...) {
        let favoriteMovies = self.memoryRepository.getAllFavoriteMovies()
        resultPublisher.onNext(favoriteMovies)
    }
}
