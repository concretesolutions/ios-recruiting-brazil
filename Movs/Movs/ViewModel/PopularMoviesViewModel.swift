//
//  PopularMoviesViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine

class PopularMoviesViewModel: ObservableObject {

    @Published private(set) var movieCount = 0
    @Published private(set) var state: ExceptionView.State = .none {
        didSet {
            self.movieCount = self.movies.count
        }
    }
    @Published private(set) var searchTerm: String = "" {
        didSet {
            self.setSearch()
        }
    }
    @Published var withoutNetwork: Bool = false {
        didSet {
            if (self.state == .none || self.state == .firstLoading) && self.withoutNetwork {
                self.state = .withoutNetwork
            }
        }
    }
    
    private var movies: [Movie] {
        return (self.state == .search) || (self.state == .searchNoData) ? self.filteredMovies : self.popularMovies
    }

    private(set) var filteredMovies: [Movie] = []
    private(set) var popularMovies: [Movie] = []

    private var currentPage: Int = 1
    private var moviesCancellable: AnyCancellable?
    private var searchTermCancellable: AnyCancellable?
    private var networkCancellable: AnyCancellable?
    private var searchIsEnableCancellable: AnyCancellable?
    
    init(withPopularMovies popularMovies: [Movie]) {
        self.popularMovies = popularMovies
    }
    
    init() {}
    
    func getMovies() {
        if !self.withoutNetwork && self.state != .search && self.state != .searchNoData {
            if self.state == .none {
                self.state = .firstLoading
            } else {
                self.state = .loading
            }
            self.moviesCancellable = MovsService.shared.popularMovies(fromPage: self.currentPage)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .failure:
                        self.state = .error
                    case .finished:
                        break
                    }
                }, receiveValue: { (movies) in
                    self.popularMovies += movies
                    self.currentPage += 1
                    self.movieCount = self.movies.count
                    self.state = .loaded
                })
        }
    }
    
    func setSearchCombine(forSearchController searchController: SearchController) {
        self.searchTermCancellable = searchController.$termPublisher
            .assign(to: \.searchTerm, on: self)
        self.searchIsEnableCancellable = self.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (state) in
            searchController.searchBar.isHidden = state == .withoutNetwork
        })
    }
    
    func setNetworkCombine() {
        self.networkCancellable = NetworkService.shared.$status
            .sink(receiveValue: { (status) in
                self.withoutNetwork = !(status == .satisfied)
            })
    }

    func viewModelForCell(at indexPath: IndexPath) -> PopularMoviesCellViewModel {
        let viewModel = PopularMoviesCellViewModel(withMovie: self.movies[indexPath.row])
        return viewModel
    }

    func viewModelDetailsForCell(at indexPath: IndexPath) -> MovieDetailsViewModel {
        let viewModel = MovieDetailsViewModel(withMovie: self.movies[indexPath.row])
        return viewModel
    }
    
    private func setSearch() {
        if !self.searchTerm.isEmpty && self.state != .withoutNetwork {
            self.filteredMovies = self.popularMovies.filter { $0.title.lowercased().contains(self.searchTerm.lowercased()) }
            self.state = self.filteredMovies.isEmpty ? .searchNoData : .search
        } else if self.currentPage != 1 {
            self.state = .loaded
        }
    }

}
