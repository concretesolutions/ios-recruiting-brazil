//
//  MoviesListViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

protocol MoviesListViewModel: AnyObject {
    var numberOfMovies: Int { get }
    var currentPresentation: Int { get }
    var navigator: MoviesListViewModelNavigator? { get set }
        
    var needShowError: ((_ message: String) -> Void)? { get set }
    var needShowNewMovies: ((_ atRange: Range<Int>) -> Void)? { get set }
    var needReloadAllMovies: (() -> Void)? { get set }
    var needReloadMovieView: ((_ position: Int) -> Void)? { get set }
    var needDeleteMovieView: ((_ position: Int) -> Void)? { get set }
    var needInsertMovieView: ((_ position: Int) -> Void)? { get set }
    
    func thePageReachedTheEnd()
    func viewModelFromMovie(atPosition position: Int) -> MovieViewModel
    func viewStateChanged(toState state: Int)
    func userSelectedMovie(atPosition position: Int)
    func reloadMovie(_ movie: Movie)
    func insertMovie(_ movie: Movie)
    func deleteMovie(_ movie: Movie)
    func deleteAllMovies()
}

enum ListState {
    case grid, cards
    
    mutating func toggle() {
        if self == .grid {
            self = .cards
        } else {
            self = .grid
        }
    }
}

enum MoviesListViewModelInjetorData {
    case normal(Movie), favorite(Movie)
}

typealias Injector<Injected, Data> = (Data) -> Injected

struct Presentation {
    var hasFavorite: Bool
}

class DefaultMoviesListViewModel: MoviesListViewModel {
    typealias MoviesRouter = (_ pageNumber: Int) -> Route
    
    var numberOfMovies: Int {
        return self.moviesPage.items.count
    }
    
    var needShowNewMovies: ((Range<Int>) -> Void)? {
        didSet {
            needShowNewMovies?(0..<moviesPage.items.count)
        }
    }
    
    var currentPresentation: Int {
        return self.currentState
    }
    
    var needReloadAllMovies: (() -> Void)?
    var needShowError: ((_ message: String) -> Void)?
    var needReloadMovieView: ((Int) -> Void)?
    var needDeleteMovieView: ((Int) -> Void)?
    var needInsertMovieView: ((Int) -> Void)?
    
    weak var navigator: MoviesListViewModelNavigator?
    
    private let moviesRepository: MoviesRepository
    private let movieViewModelInjector: Injector<MovieViewModel, MoviesListViewModelInjetorData>
    private var moviesPage = Page<Movie>()
    private var presentations: [Presentation]
    
    private var currentState: Int = 0 {
        didSet {
            self.needReloadAllMovies?()
        }
    }

    init(moviesRepository: MoviesRepository, presentations: [Presentation], movieViewModelInjector: @escaping Injector<MovieViewModel, MoviesListViewModelInjetorData>) {
        self.moviesRepository = moviesRepository
        self.movieViewModelInjector = movieViewModelInjector
        self.presentations = presentations
    }
    
    private func getMovies() {
        guard let nextPage = moviesPage.nextPage else {
            return
        }
        moviesRepository.getMovies(fromPage: nextPage) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let moviesPage):
                self.handleMoviesResult(page: moviesPage)
            case .failure(let error):
                self.needShowError?(error.localizedDescription)
            }
        }
    }
    
    private func handleMoviesResult(page moviesPage: Page<Movie>) {
        let totalOfMovies = self.moviesPage.items.count + moviesPage.items.count
        let newMoviesRange = self.moviesPage.items.count ..< totalOfMovies
        
        self.moviesPage.addNewPage(moviesPage)
        
        if moviesPage.pageNumber == 1 {
            self.needReloadAllMovies?()
        } else {
            self.needShowNewMovies?(newMoviesRange)
        }
    }
    
    func thePageReachedTheEnd() {
        getMovies()
    }
    
    func viewModelFromMovie(atPosition position: Int) -> MovieViewModel {
        guard moviesPage.isValidPosition(position) else {
            fatalError("The \(position) position is wrong, the total of movies is \(moviesPage.numberOfItem)")
        }

        if self.presentations[currentState].hasFavorite {
            let movieViewModel = movieViewModelInjector(.favorite(moviesPage.items[position]))
            movieViewModel.withFavoriteOptions?.navigator = self
            return movieViewModel
        } else {
            return movieViewModelInjector(.normal(moviesPage.items[position]))
        }
    }
    
    func viewStateChanged(toState state: Int) {
        guard state >= 0 && state < presentations.count else {
            fatalError("The \(state) state is wrong, the total of presentations modes is \(presentations.count)")
        }
        self.currentState = state
    }
    
    func userSelectedMovie(atPosition position: Int) {
        guard moviesPage.isValidPosition(position) else {
            fatalError("The \(position) position is wrong, the total of movies is \(moviesPage.numberOfItem)")
        }
        
        navigator?.movieWasSelected(movie: moviesPage.items[position])
    }
    
    func reloadMovie(_ movie: Movie) {
        findPositionOf(movie: movie) { (moviePosition) in
            needReloadMovieView?(moviePosition)
        }
    }
    
    func deleteMovie(_ movie: Movie) {
        findPositionOf(movie: movie) { (moviePosition) in
            self.moviesPage.items.remove(at: moviePosition)
            self.needDeleteMovieView?(moviePosition)
        }
    }
    
    func insertMovie(_ movie: Movie) {
        self.moviesPage.items.insert(movie, at: 0)
        self.needInsertMovieView?(0)
    }
    
    private func findPositionOf(movie: Movie, completion: (Int) -> Void) {
        let favedMoviePosition = self.moviesPage.positionOf { (currentMovie) -> Bool in
            return currentMovie.id == movie.id
        }

        guard let safefavedMoviePosition = favedMoviePosition else {
            return
        }
           
        completion(safefavedMoviePosition)
    }
    
    func deleteAllMovies() {
        moviesPage = Page<Movie>()
        self.needReloadAllMovies?()
    }
}

extension DefaultMoviesListViewModel: MovieViewModelWithFavoriteOptionsNavigator {
    func userFavedMovie(movie: Movie) {
        self.navigator?.movieWasFaved(movie: movie)
    }
    
    func userUnFavedMovie(movie: Movie) {
        self.navigator?.movieWasUnfaved(movie: movie)
    }
}
