//
//  LoadMoviesFromNetworkAndCacheUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import RxSwift

/// Este caso de uso realiza o carregamento de 1 página da API e salvo o mesmo no repositório de memória, é importante explicitar que este caso de uso também registra a última página a ser carregada por ele e o mesmo só realiza o carregamento da próxima página não carregada.
final class LoadMoviesFromNetworkAndCacheUseCase {
    
    private var convertMovieEntityToModelUseCase: ConvertMovieEntityToModelUseCase
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var networkRepository: MovieNetworkRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    private var lastPageRequested = 1
    
    private let moviesLoadedPublisher = PublishSubject<[Movie]>()
    
    var moviesLoadedStream: Observable <[Movie]> {
        get {
            return moviesLoadedPublisher.asObservable()
        }
    }
    
    init(memoryRepository: MovieMemoryRepositoryProtocol,
         networkRepository: MovieNetworkRepositoryProtocol,
         convertMovieEntityToModelUseCase: ConvertMovieEntityToModelUseCase) {
        
        self.memoryRepository = memoryRepository
        self.networkRepository = networkRepository
        self.convertMovieEntityToModelUseCase = convertMovieEntityToModelUseCase
        
        self.networkRepository.getMoviesStream.subscribe(onNext: { [weak self] (page, movies) in
            self?.convertAndSendMovies(page: page, movies: movies)
            }, onError: {
            [weak self] error in
                self?.moviesLoadedPublisher.onError(error)
        }).disposed(by: disposeBag)
    }
    
    private func convertAndSendMovies(page: Int, movies: [MovieEntity]) {
        let moviesAux = self.convertMovieEntityToModelUseCase.run(movies: movies)
        self.memoryRepository.cache(page: page, movies: moviesAux)
        self.moviesLoadedPublisher.onNext(self.memoryRepository.getAllMovies())
    }
    
    func run(){
        if !memoryRepository.isPageLoaded(page: lastPageRequested) {
            networkRepository.getMovies(page: lastPageRequested)
            
            lastPageRequested += 1
        } else {
            self.moviesLoadedPublisher.onNext(self.memoryRepository.getAllMovies())
        }
    }
}
