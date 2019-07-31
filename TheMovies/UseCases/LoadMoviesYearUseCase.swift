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
final class LoadMoviesYearUseCase {
        
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    // Outputs
    private let yearsLoadedPublisher = PublishSubject<Bool>()
    var yearsLoadedStream: Observable <Bool> {
        get {
            return yearsLoadedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
    }
    
    func run() -> Set<String>{
        return self.memoryRepository.getMoviesYear()
    }
}
