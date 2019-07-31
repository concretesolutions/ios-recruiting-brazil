//
//  MoviesGridPresenter.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesGridPresenterProtocol {
    var loadMoviesStream: Observable<[Movie]> { get }
    var reloadMoviesStream: Observable<[Movie]> { get }
    
    func loadNewPageMoviesFromNetwork()
    func loadMoviesFromCache()
    func movieCellWasTapped(id: Int)
    func cacheGenres()
}

final class MoviesGridPresenter: MoviesGridPresenterProtocol {
    
    private let loadMoviesUseCase: UseCase<Void, Array<Movie>>
    private let showMovieDetailsUseCase: UseCase<Int, Bool>
    private let loadGenresAndCacheUseCase: UseCase<Void, Bool>
    private let loadMoviesFromCacheUseCase: UseCase<Void, Array<Movie>>
    
    private let disposeBag = DisposeBag()
    
    
    /// Fluxo de retorno: É chamado quando os filmes acabam de ser carregados da API (Já estão em cache na memória)
    private let loadMoviesPublisher = BehaviorSubject<[Movie]>(value: [])
    var loadMoviesStream: Observable<[Movie]> {
        get {
            return loadMoviesPublisher.asObservable()
        }
    }
    
    /// Fluxo de retorno: É chamado quando os filmes acabam de ser carregados da memória
    private let reloadMoviesPublisher = BehaviorSubject<[Movie]>(value: [])
    var reloadMoviesStream: Observable<[Movie]> {
        get {
            return reloadMoviesPublisher.asObservable()
        }
    }
    
    init(loadMoviesUseCase: UseCase<Void, Array<Movie>>,
         showMovieDetailsUseCase: UseCase<Int, Bool>,
         loadGenresAndCacheUseCase: UseCase<Void, Bool>,
         loadMoviesFromCacheUseCase: UseCase<Void, Array<Movie>>) {
        self.loadMoviesUseCase = loadMoviesUseCase
        self.showMovieDetailsUseCase = showMovieDetailsUseCase
        self.loadGenresAndCacheUseCase = loadGenresAndCacheUseCase
        self.loadMoviesFromCacheUseCase = loadMoviesFromCacheUseCase
        
        self.loadMoviesUseCase.resultStream.bind(to: loadMoviesPublisher).disposed(by: disposeBag)
        self.loadMoviesFromCacheUseCase.resultStream.bind(to: reloadMoviesPublisher).disposed(by: disposeBag)
    }
    
    
    /// Carrega filmes diretamente da API
    func loadNewPageMoviesFromNetwork() {
        loadMoviesUseCase.run()
    }
    
    /// Carrega filmes do cache na memória
    func loadMoviesFromCache() {
        loadMoviesFromCacheUseCase.run()
    }
    
    /// Mostra a tela de detalhes
    ///
    /// - Parameter id: Índice da célula que foi clicada
    func movieCellWasTapped(id: Int) {
        showMovieDetailsUseCase.run(id)
    }
    
    /// Realiza o cache dos gêneros
    func cacheGenres() {
        self.loadGenresAndCacheUseCase.run()
    }
}
