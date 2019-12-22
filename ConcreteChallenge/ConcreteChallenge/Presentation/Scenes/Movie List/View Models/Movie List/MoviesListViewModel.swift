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
    var mustShowGridMode: Bool { get }
    var navigator: MoviesListViewModelNavigator? { get set }
        
    var needShowError: ((_ message: String) -> Void)? { get set }
    var needShowNewMovies: ((_ atRange: Range<Int>) -> Void)? { get set }
    var needReloadAllMovies: (() -> Void)? { get set }
    
    func thePageReachedTheEnd()
    func viewModelFromMovie(atPosition position: Int) -> MovieViewModel
    func viewStateChanged()
    func userSelectedMovie(atPosition position: Int)
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

typealias Injector<Injected, Data> = (Data) -> Injected

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
    
    var mustShowGridMode: Bool {
        return self.state == .grid
    }
    
    var needReloadAllMovies: (() -> Void)?
    var needShowError: ((_ message: String) -> Void)?
    
    weak var navigator: MoviesListViewModelNavigator?
    
    private let moviesRepository: MoviesRepository
    private let movieViewModelInjector: Injector<MovieViewModel, Movie>
    private var moviesPage = Page<Movie>()
    private var state = ListState.grid {
        didSet {
            self.needReloadAllMovies?()
        }
    }
    
    init(moviesRepository: MoviesRepository, movieViewModelInjector: @escaping Injector<MovieViewModel, Movie>) {
        self.moviesRepository = moviesRepository
        self.movieViewModelInjector = movieViewModelInjector
    }
    
    private func getMovies() {
        moviesRepository.getMovies(fromPage: moviesPage.nextPage) { [weak self] (result) in
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

        return movieViewModelInjector(moviesPage.items[position])
    }
    
    func viewStateChanged() {
        self.state.toggle()
    }
    
    func userSelectedMovie(atPosition position: Int) {
        guard moviesPage.isValidPosition(position) else {
            fatalError("The \(position) position is wrong, the total of movies is \(moviesPage.numberOfItem)")
        }
        
        navigator?.movieWasSelected(movie: moviesPage.items[position])
    }
}
