//
//  LoadGenresFromCacheUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

/// Carrega todos os generos do cache
final class LoadGenresFromCacheUseCase {
    
    private var memoryRepository: GenreMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    // Outputs
    private let genresLoadedPublisher = PublishSubject<[Genre]>()
    var genresLoadedStream: Observable <[Genre]> {
        get {
            return genresLoadedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: GenreMemoryRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
    }
    
    func run(){
        genresLoadedPublisher.onNext(self.memoryRepository.getAll())
    }
}
