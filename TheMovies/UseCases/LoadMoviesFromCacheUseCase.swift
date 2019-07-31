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
final class LoadMoviesFromCacheUseCase: UseCase<Void, Array<Movie>> {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    private var lastPageRequested = 1
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
    }
    
    override func run(_ params: Void...){
        self.resultPublisher.onNext(self.memoryRepository.getAllMovies())
    }
}
