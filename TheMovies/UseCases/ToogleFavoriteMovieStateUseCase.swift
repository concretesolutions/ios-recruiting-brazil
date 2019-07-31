//
//  FavoriteMovieUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Favorita/Desfavorita um filme
final class ToogleFavoriteMovieStateUseCase: UseCase<Int, Movie> {
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    enum FavoriteMovieUseCaseError: Error {
        case MovieNotFound
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        self.memoryRepository = memoryRepository
    }
    
    override func run(_ params: Int...){
        
        guard let id = params.first else {
            fatalError("This use case needs the parameter id(Int)")
        }
        
        guard let result = self.memoryRepository.setFavoriteMovie(id: id) else {
            resultPublisher.onError(FavoriteMovieUseCaseError.MovieNotFound)
            return
        }
        
        resultPublisher.onNext(result)
    }
}
