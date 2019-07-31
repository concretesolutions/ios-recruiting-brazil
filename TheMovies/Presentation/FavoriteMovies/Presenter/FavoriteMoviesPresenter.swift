//
//  FavoriteMoviesPresenter.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

protocol FavoriteMoviesPresenterProtocol {
    var loadFavoriteMoviesStream: Observable<[Movie]> { get }
    var movieUnfavoritedStream: Observable<Movie> { get }
    var loadMoviesYearStream: Observable<Set<String>> { get }
    var loadMoviesGenresStream: Observable<[String]> { get }
    var setFilterStream: Observable<(String, String)> { get }
    
    func loadFavoriteMovies()
    func unfavoriteMovieButtonWasTapped(id: Int)
    func loadMoviesYear()
    func loadMoviesGenres()
}

final class FavoriteMoviesPresenter: FavoriteMoviesPresenterProtocol {
    
    private var disposeBag = DisposeBag()
    
    private var loadFavoriteMoviesUseCase: LoadFavoriteMoviesUseCase
    private var favoriteMovieUseCase: ToogleFavoriteMovieStateUseCase
    private var loadMoviesYearUseCase: LoadMoviesYearUseCase
    private var loadGenresFromCacheUseCase: LoadGenresFromCacheUseCase
    
    private var loadFavoriteMoviesPublisher = BehaviorSubject<[Movie]>(value: [])
    var loadFavoriteMoviesStream: Observable<[Movie]> {
        get {
            return loadFavoriteMoviesPublisher.asObservable()
        }
    }
    
    private var movieUnfavoritedPublisher = PublishSubject<Movie>()
    var movieUnfavoritedStream: Observable<Movie> {
        get {
            return movieUnfavoritedPublisher.asObservable()
        }
    }
    
    private var loadMoviesYearPublisher = BehaviorSubject<Set<String>>(value: [])
    var loadMoviesYearStream: Observable<Set<String>> {
        get {
            return loadMoviesYearPublisher.asObservable()
        }
    }
    
    private var loadMoviesGenresPublisher = BehaviorSubject<[String]>(value: [])
    var loadMoviesGenresStream: Observable<[String]> {
        get {
            return loadMoviesGenresPublisher.asObservable()
        }
    }
    
    private var setFilterPublisher = BehaviorSubject<(String, String)>(value: ("", ""))
    var setFilterStream: Observable<(String, String)> {
        get {
            return setFilterPublisher.asObservable()
        }
    }
    
    init(loadFavoriteMoviesUseCase: LoadFavoriteMoviesUseCase,
         favoriteMovieUseCase: ToogleFavoriteMovieStateUseCase,
         loadMoviesYearUseCase: LoadMoviesYearUseCase,
         loadGenresFromCacheUseCase: LoadGenresFromCacheUseCase) {
        self.loadFavoriteMoviesUseCase = loadFavoriteMoviesUseCase
        self.favoriteMovieUseCase = favoriteMovieUseCase
        self.loadMoviesYearUseCase = loadMoviesYearUseCase
        self.loadGenresFromCacheUseCase = loadGenresFromCacheUseCase
        
        self.loadFavoriteMoviesUseCase.moviesLoadedStream.bind(to: loadFavoriteMoviesPublisher).disposed(by: disposeBag)
        self.loadGenresFromCacheUseCase.genresLoadedStream.bind {
            [weak self] genres in
            self?.publishGenreNames(genres: genres)
        }.disposed(by: disposeBag)
        self.favoriteMovieUseCase.movieFavoritedStream.bind(to: movieUnfavoritedPublisher).disposed(by: disposeBag)
    }
    
    
    fileprivate func publishGenreNames(genres: [Genre]) {
        var genreAux = [String]()
        for genre in genres {
            genreAux.append(genre.name)
        }
        
        self.loadMoviesGenresPublisher.onNext(genreAux)
    }
    
    /// Carrega todos os filmes favoritados
    func loadFavoriteMovies() {
        self.loadFavoriteMoviesUseCase.run()
    }
    
    /// Desfavorita um filme
    ///
    /// - Parameter id: identicação do filme
    func unfavoriteMovieButtonWasTapped(id: Int) {
        self.favoriteMovieUseCase.run(with: id)
    }
    
    
    /// Carrega todos os anos dos filmes já guardados no cache
    func loadMoviesYear() {
        self.loadMoviesYearPublisher.onNext(self.loadMoviesYearUseCase.run())
    }
    
    /// Carrega todos os generos dos filmes
    func loadMoviesGenres() {
        self.loadGenresFromCacheUseCase.run()
    }
    
    
    /// Emite um sinal avisando que o filtro foi submetido
    ///
    /// - Parameters:
    ///   - date: filtro de data
    ///   - genre: filtro de gênero
    func filterResults(with date: String,
        and genre: String) {
        self.setFilterPublisher.onNext((date, genre))
    }
}
