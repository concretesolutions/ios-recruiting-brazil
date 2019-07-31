//
//  LoadGenresAndCacheUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa


/// Carrega todos os Gêneros da API e salva em cache na memória
final class LoadGenresAndCacheUseCase {
    
    private var memoryRepository: GenreMemoryRepositoryProtocol
    private var networkRepository: GenreNetworkRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    // Outputs
    private let genresLoadedPublisher = PublishSubject<Bool>()
    var genresLoadedStream: Observable <Bool> {
        get {
            return genresLoadedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: GenreMemoryRepositoryProtocol,
         networkRepository: GenreNetworkRepositoryProtocol) {
        
        self.memoryRepository = memoryRepository
        self.networkRepository = networkRepository
        
        self.networkRepository.getGenresStream.bind { [weak self] (genres) in
            self?.memoryRepository.cache(genres: genres)
            self?.genresLoadedPublisher.onNext(true)
        }.disposed(by: disposeBag)
    }
    
    func run(){
        self.networkRepository.getGenres()
    }
}
