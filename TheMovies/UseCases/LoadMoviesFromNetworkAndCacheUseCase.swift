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
final class LoadMoviesFromNetworkAndCacheUseCase: UseCase<Void, Array<Movie>> {
    
    private var convertMovieEntityToModelUseCase: UseCase<Array<MovieEntity>, Array<Movie>>
    private var memoryRepository: MovieMemoryRepositoryProtocol
    private var networkRepository: MovieNetworkRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    private var nextPageToRequested = 1
    private var currentPage = 0
    
    init(memoryRepository: MovieMemoryRepositoryProtocol,
         networkRepository: MovieNetworkRepositoryProtocol,
         convertMovieEntityToModelUseCase: UseCase<Array<MovieEntity>, Array<Movie>>) {
        
        self.memoryRepository = memoryRepository
        self.networkRepository = networkRepository
        self.convertMovieEntityToModelUseCase = convertMovieEntityToModelUseCase
        
        super.init()
        
        self.networkRepository.getMoviesStream.subscribe(onNext: { [weak self] (page, movies) in
            self?.currentPage = page
            self?.convertAndSendMovies(movies: movies)
            }, onError: {
            [weak self] error in
                self?.resultPublisher.onError(error)
        }).disposed(by: disposeBag)
        
        self.convertMovieEntityToModelUseCase.resultStream.subscribe(onNext: {
            [weak self] movies in
            
            guard let page = self?.currentPage else {
                return
            }
            
            self?.memoryRepository.cache(page: page, movies: movies)
            
            guard let moviesAux = self?.memoryRepository.getAllMovies() else {
                return
            }
            
            self?.resultPublisher.onNext(moviesAux)
        }).disposed(by: disposeBag)
    }
    
    private func convertAndSendMovies(movies: [MovieEntity]) {
        self.convertMovieEntityToModelUseCase.run(movies)
    }
    
    override func run(_ params: Void...){
        if !memoryRepository.isPageLoaded(page: nextPageToRequested) {
            networkRepository.getMovies(page: nextPageToRequested)
            
            nextPageToRequested += 1
        } else {
            self.resultPublisher.onNext(self.memoryRepository.getAllMovies())
        }
    }
}
