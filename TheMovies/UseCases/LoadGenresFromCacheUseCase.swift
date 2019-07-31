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
final class LoadGenresFromCacheUseCase: UseCase<Void, Array<Genre>> {
    
    private var memoryRepository: GenreMemoryRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    init(memoryRepository: GenreMemoryRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
    }
    
    override func run(_ params: Void...){
        self.resultPublisher.onNext(self.memoryRepository.getAll())
    }
}
