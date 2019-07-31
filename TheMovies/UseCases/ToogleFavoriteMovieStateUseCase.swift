//
//  FavoriteMovieUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Favorita/Desfavorita um filme
final class ToogleFavoriteMovieStateUseCase {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    enum FavoriteMovieUseCaseError: Error {
        case MovieNotFound
    }
    
    // Outputs
    private let movieFavoritedPublisher = PublishSubject<Movie>()
    var movieFavoritedStream: Observable <Movie> {
        get {
            return movieFavoritedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        self.memoryRepository = memoryRepository
    }
    
    func run(with id: Int){
        guard let result = self.memoryRepository.setFavoriteMovie(id: id) else {
            movieFavoritedPublisher.onError(FavoriteMovieUseCaseError.MovieNotFound)
            return
        }
        movieFavoritedPublisher.onNext(result)
    }
}
