//
//  LoadMoviesYearUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift
import UIKit
import Swinject

/// Carrega os anos dos filmes já armazenados em cache
final class LoadMoviesYearUseCase: UseCase<Void, Set<String>> {
    
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
    }
    
    override func run(_ params: Void...) {
        resultPublisher.onNext(self.memoryRepository.getMoviesYear())
    }
}
