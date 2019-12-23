//
//  DefaultMoviesListViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class DefaultMoviesListViewModel: MoviesListViewModel {    
    var numberOfMovies: Int {
        return self.moviesPage.items.count
    }
    
    var needShowNewMovies: ((Range<Int>) -> Void)? {
        didSet {
            self.needReloadAllMovies?()
        }
    }
    
    var currentPresentation: Int {
        return self.currentState
    }
    
    var emptyStateDescription: String {
        return self.emptyStateTitle
    }
    
    var needReloadAllMovies: (() -> Void)?
    var needShowError: ((_ message: String) -> Void)?
    var needReloadMovieView: ((Int) -> Void)?
    var needDeleteMovieView: ((Int) -> Void)?
    var needInsertMovieView: ((Int) -> Void)?
    var needChangeLoadingStateVisibility: ((Bool) -> Void)? {
        didSet {
            if moviesPage.items.count == 0 {
                self.needChangeLoadingStateVisibility?(true)
            } else {
                self.needChangeEmptyStateVisibility?(false)
            }
        }
    }
    var needChangeEmptyStateVisibility: ((Bool) -> Void)? {
        didSet {
            if moviesPage.items.count == 0 {
                self.needChangeEmptyStateVisibility?(true)
            } else {
                self.needChangeEmptyStateVisibility?(false)
            }
        }
    }
    weak var navigator: MoviesListViewModelNavigator?
    
    private let moviesRepository: MoviesRepository
    private let movieViewModelInjector: Injector<MovieViewModel, DefaultMoviesListViewModel.InjetorData>
    private var moviesPage = Page<Movie>()
    private var presentations: [Presentation]
    private let emptyStateTitle: String
    
    private var currentState: Int = 0 {
        didSet {
            self.needReloadAllMovies?()
        }
    }

    init(moviesRepository: MoviesRepository,
         presentations: [Presentation],
         emptyStateTitle: String? = nil,
         movieViewModelInjector: @escaping Injector<MovieViewModel, DefaultMoviesListViewModel.InjetorData>) {

        self.moviesRepository = moviesRepository
        self.movieViewModelInjector = movieViewModelInjector
        self.presentations = presentations
        self.emptyStateTitle = emptyStateTitle ?? "No movies were find."
    }
    
    private func getMovies() {
        guard let nextPage = moviesPage.nextPage else {
            
            self.needChangeLoadingStateVisibility?(false)
            return
        }
        self.needChangeLoadingStateVisibility?(true)
        moviesRepository.getMovies(fromPage: nextPage) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let moviesPage):
                self.handleMoviesResult(page: moviesPage)
            case .failure(let error):
                self.needShowError?(error.localizedDescription)
            }
            self.needChangeLoadingStateVisibility?(false)
        }
    }
    
    private func handleMoviesResult(page moviesPage: Page<Movie>) {
        let totalOfMovies = self.moviesPage.items.count + moviesPage.items.count
        let newMoviesRange = self.moviesPage.items.count ..< totalOfMovies
        
        self.moviesPage.addNewPage(moviesPage)
        
        if moviesPage.items.count == 0 {
            needChangeEmptyStateVisibility?(true)
        } else {
            needChangeEmptyStateVisibility?(false)
        }
        
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
            movieViewModel.withFavoriteOptions?.favoritesNavigator = self
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
        guard moviesPage.pageNumber > 0 else {
            return
        }
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
        self.needChangeEmptyStateVisibility?(true)
    }
    
    struct Presentation {
        var hasFavorite: Bool
    }
    
    enum InjetorData {
        case normal(Movie), favorite(Movie)
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
