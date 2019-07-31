//
//  MovieDetailsPresenter.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

protocol MovieDetailsPresenterProtocol {
    var loadMovieDetailStream: Observable<[Movie]> { get }
    var movieWasFavoritedStream: Observable<Movie> { get }
    
    func loadMovieDetail(id: Int)
    func favoriteMovieButtonWasTapped(id: Int)
}

final class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    private var disposeBag = DisposeBag()
    private var loadMovieDetailUseCase: LoadMovieDetailUseCase
    private var favoriteMovieUseCase: ToogleFavoriteMovieStateUseCase
    
    
    /// Fluxo de retorno: É chamado quando os detalhes do filme especificado for carregado
    private var loadMovieDetailPublisher = PublishSubject<[Movie]>()
    var loadMovieDetailStream: Observable<[Movie]> {
        get {
            return loadMovieDetailPublisher.asObservable()
        }
    }
    
    /// Fluxo de retorno: É chamado como confirmação de que o filme foi favoritado no repositório
    private var movieWasFavoritedPublisher = PublishSubject<Movie>()
    var movieWasFavoritedStream: Observable<Movie> {
        get {
            return movieWasFavoritedPublisher.asObservable()
        }
    }
    
    init(loadMovieDetailUseCase: LoadMovieDetailUseCase,
         favoriteMovieUseCase: ToogleFavoriteMovieStateUseCase) {
        self.loadMovieDetailUseCase = loadMovieDetailUseCase
        self.favoriteMovieUseCase = favoriteMovieUseCase
        
        self.loadMovieDetailUseCase.loadMovieDetailStream.bind(to: loadMovieDetailPublisher).disposed(by: disposeBag)
        self.favoriteMovieUseCase.movieFavoritedStream.bind(to: movieWasFavoritedPublisher).disposed(by: disposeBag)
    }
    
    
    /// Carrega os detalhes de um filme
    ///
    /// - Parameter id: identificação do filme a ser carregado
    func loadMovieDetail(id: Int) {
        self.loadMovieDetailUseCase.run(with: id)
    }
    
    
    /// Indica que um filme foi favoritado
    ///
    /// - Parameter id: identificação do filme a ser favoritado
    func favoriteMovieButtonWasTapped(id: Int) {
        self.favoriteMovieUseCase.run(with: id)
    }
}
