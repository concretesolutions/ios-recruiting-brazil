//
//  PopularMoviesViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine

class PopularMoviesViewModel {

    @Published var count = 0

    var movies: [Movie] {
        return self.isSearching ? self.filteredMovies : self.popularMovies
    }

    private var filteredMovies: [Movie] = [] {
        didSet {
            self.count = self.filteredMovies.count
        }
    }
    private var popularMovies: [Movie] = [] {
        didSet {
            self.count = self.popularMovies.count
        }
    }

    private var currentPage: Int = 1
    private var moviesCancellable: AnyCancellable?

    var isSearching: Bool = false {
        didSet {
            self.count = self.movies.count
        }
    }

    init() {
        self.getMovies()
    }

    public func getMovies() {
        self.moviesCancellable = MovsServiceAPI.popularMovies(fromPage: self.currentPage)
            .assertNoFailure("Deu ruim pegando filmes populares")
            .sink { (movies) in
                self.popularMovies += movies
                self.currentPage += 1
        }
    }

    func search(formTerm term: String) {
        if term.isEmpty {
            self.filteredMovies = self.popularMovies
        } else {
            self.filteredMovies = self.popularMovies.filter { $0.title.lowercased().contains(term.lowercased()) }
        }
        self.count = self.filteredMovies.count
    }

    func viewModel(forCellAt indexPath: IndexPath) -> PopularMoviesCellViewModel {
        let viewModel = PopularMoviesCellViewModel(withMovie: self.movies[indexPath.row])
        return viewModel
    }

    func viewModel1(forCellAt indexPath: IndexPath) -> MovieDetailsViewModel {
        let viewModel = MovieDetailsViewModel(withMovie: self.movies[indexPath.row])
        return viewModel
    }

}
