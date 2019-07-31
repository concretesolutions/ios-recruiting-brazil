//
//  LoadMoviesFromCacheUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//


import Foundation
import RxSwift


/// Caso de uso responsável por carregar filmes do respositória na memória
final class LoadMoviesFromCacheUseCase {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    private var lastPageRequested = 1
    
    // Outputs
    private let moviesLoadedPublisher = PublishSubject<[Movie]>()
    var moviesLoadedStream: Observable <[Movie]> {
        get {
            return moviesLoadedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
    }
    
    func run(){
        self.moviesLoadedPublisher.onNext(self.memoryRepository.getAllMovies())
    }
}
