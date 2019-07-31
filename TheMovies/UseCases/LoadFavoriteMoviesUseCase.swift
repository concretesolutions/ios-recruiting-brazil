//
//  LoadFavoriteMoviesUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Este caso de uso carrega todos os filmes favoritados da memória
final class LoadFavoriteMoviesUseCase {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    private let moviesLoadedPublisher = PublishSubject<[Movie]>()
    /// Fluxo: É chamado após o carregamento de todos os filmes favoritados
    var moviesLoadedStream: Observable <[Movie]> {
        get {
            return moviesLoadedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        self.memoryRepository = memoryRepository
    }
    
    func run(){
        let favoriteMovies = self.memoryRepository.getAllFavoriteMovies()
        moviesLoadedPublisher.onNext(favoriteMovies)
    }
}
