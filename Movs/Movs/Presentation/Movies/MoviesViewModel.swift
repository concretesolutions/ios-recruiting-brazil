//
//  MoviesViewModel.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 13/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

public enum PresentationState {
    case loadingContent
    case displayingContent
    case error
    case emptySearch
}

public protocol MoviesViewModelable: Registrable {
    var movieSearchText: String { get set }
    var genres: Observable<[Genre]> { get }
    var filteredMovies: Observable<[Movie]> { get }
    var presentationState: Observable<PresentationState> { get }
    func shouldFetch(page: Int)
    func loadData()
    func initialize()
}

public class MoviesViewModel: MoviesViewModelable {

    // MARK: - Public properties
    public var presentationState = Observable<PresentationState>(.loadingContent)

    //TMDB API
    let movieService = DependencyResolver.shared.resolve(MovieService.self)
    //Properties
    public var filteredMovies = Observable<[Movie]>([Movie]())
    private var movies = Observable<[Movie]>([Movie]())
    public var genres = Observable<[Genre]>([Genre]())
    public var movieSearchText: String = "" {
        didSet {
            reloadFilteredMovies()
        }
    }
    private var dataUpdated = Observable<Bool>(false)
    private var currentPage = 0

    public init() {
        fetchGenres()
    }

    func reloadFilteredMovies() {
        guard !movieSearchText.isEmpty else {
            self.filteredMovies.value = movies.value
            presentationState.value = .displayingContent
            return
        }
        self.filteredMovies.value = movies.value.filter { movie -> Bool in
            movie.title.contains(movieSearchText)
        }
        presentationState.value = filteredMovies.value.isEmpty ? .emptySearch : .displayingContent
    }

    func fetchGenres() {
        self.presentationState.value = .loadingContent
        movieService.getGenres { result in
            switch result {
            case .success(let genres):
                self.genres.value = genres
                self.fetchMovies(page: 1)
                self.currentPage = 1
            case .error:
                self.presentationState.value = .error
            }
        }
    }

    func fetchMovies(page: Int) {
        movieService.getPopularMovies(page: page) { result in
            switch result {
            case .success(let movies):
                var collection = self.self.movies.value
                collection.append(contentsOf: movies)
                self.movies.value = collection
                self.presentationState.value = .displayingContent
                self.getMoviesFromRealm()
            case .error(let error):
                self.presentationState.value = .error
                print(error.localizedDescription)
            }
        }
    }

    public func initialize() {
        movies.bind { _ in
            self.reloadFilteredMovies()
        }
        dataUpdated.bind { _ in
            self.reloadFilteredMovies()
        }
    }

    public func loadData() {
        getMoviesFromRealm()
    }

    func getMoviesFromRealm() {
        self.clearFavoriteMovies()
        if let favoritedMovies = RealmManager.shared.getAll(objectsOf: MovieRealm.self) {
            for favoritedMovie in favoritedMovies {
                for (index, movie) in self.movies.value.enumerated() where favoritedMovie.id == movie.id {
                    self.movies.value[index].isFavorite = true
                }
            }
            self.presentationState.value = .displayingContent
            self.dataUpdated.value = true
        }
    }

    func clearFavoriteMovies() {
        for index in self.movies.value.indices {
            self.movies.value[index].isFavorite = false
        }
    }

    public func shouldFetch(page: Int) {
        if page == self.currentPage + 1 {
            self.currentPage += 1
            self.fetchMovies(page: self.currentPage)
        }
    }
}
