
//
//  LoadMovieDetailUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Este caso de uso é responsável por carregar os detalhes de um filme
final class LoadMovieDetailUseCase {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    private let loadMovieDetailPublisher = PublishSubject<[Movie]>()
    
    /// Fluxo: Retorna todos os filmes que contém o id previamente informado assim que todos forem carregados
    var loadMovieDetailStream: Observable <[Movie]> {
        get {
            return loadMovieDetailPublisher.asObservable()
        }
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        self.memoryRepository = memoryRepository
    }
    
    
    /// Carrega os detalhes de um filme
    ///
    /// - Parameter id: Identificação do filme
    func run(with id: Int){
        self.loadMovieDetailPublisher.onNext(self.memoryRepository.getMovie(from: id))
    }
}

