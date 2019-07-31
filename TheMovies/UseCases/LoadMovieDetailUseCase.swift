
//
//  LoadMovieDetailUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Este caso de uso é responsável por carregar os detalhes de um filme
final class LoadMovieDetailUseCase: UseCase<Int, Array<Movie>> {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        self.memoryRepository = memoryRepository
    }
    
    
    /// Carrega os detalhes de um filme
    ///
    /// - Parameter id: Identificação do filme
    override func run(_ params: Int...){
        
        guard let id = params.first else {
            fatalError("This use case needs the parameter id")
        }
        
        self.resultPublisher.onNext(self.memoryRepository.getMovie(from: id))
    }
}

