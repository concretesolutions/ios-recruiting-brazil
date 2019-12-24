//
//  FavoriteMoviesViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine

class FavoriteMoviesViewModel: ObservableObject {

    @Published var movieCount = 0
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
            } else if !self.withoutNetwork && self.state == .withoutNetwork {
                self.getFavoriteMovies()
            }
        }
    }

    private var movies: [Movie] {
        return (self.state == .search) || (self.state == .searchNoData) ? self.filteredMovies : self.favoriteMovies
    }
    
    private var filteredMovies: [Movie] = []
    private var favoriteMovies: [Movie] = []

    private var moviesCancellables: [AnyCancellable] = []
    private var searchTermCancellable: AnyCancellable?
    private var networkCancellable: AnyCancellable?
    private var favoritesCancellable: AnyCancellable?
    private var searchIsEnableCancellable: AnyCancellable?
    
    private var firstRequest: Bool = true

    init() {
        self.favoritesCancellable = PersistenceService.publisher.sink { (_) in
            self.tryGetFavoriteMovies()
        }
    }
    
    init(withFavoriteMovies favoriteMovies: [Movie]) {
        self.favoriteMovies = favoriteMovies
    }
    
    private func tryGetFavoriteMovies() {
        if !self.withoutNetwork {
            self.getFavoriteMovies()
        }
    }

    private func getFavoriteMovies() {
        if PersistenceService.favoriteMovies.isEmpty {
            self.state = .noFavorites
            self.favoriteMovies.removeAll()
            self.movieCount = self.movies.count
            return
        }
        if self.state == .none {
            self.state = .firstLoading
        } else {
            self.state = .loading
        }
        let oldFavoriteMovies = self.favoriteMovies.compactMap { $0.id }
        let newFavoriteMovies = PersistenceService.favoriteMovies
        let newSet = Set(newFavoriteMovies)
        let oldSet = Set(oldFavoriteMovies)
        let ids = Array(newSet.symmetricDifference(oldSet))
        if newFavoriteMovies.count > oldFavoriteMovies.count {
            for id in ids {
                let cancellable = MovsService.shared.getMovie(withId: id)
                    .sink(receiveCompletion: { (completion) in
                        switch completion {
                        case .failure:
                            self.state = .error
                        case .finished:
                            break
                        }
                    }, receiveValue: { (movie) in
                        self.favoriteMovies.append(movie)
                        self.movieCount = self.movies.count
                        self.state = .loaded
                        self.firstRequest = false
                    })
                self.moviesCancellables.append(cancellable)
            }
        } else {
            self.favoriteMovies.removeAll { $0.id == ids.first! }
            self.movieCount = self.movies.count
            self.state = .loaded
            self.firstRequest = false
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

    func viewModelForCell(at indexPath: IndexPath) -> FavoriteMoviesCellViewModel {
        let viewModel = FavoriteMoviesCellViewModel(withMovie: self.movies[indexPath.row])
        return viewModel
    }
    
    func movieId(forCellAt indexPath: IndexPath) -> Int {
        return self.movies[indexPath.row].id
    }
    
    private func getNewFavorites() -> [Int] {
        let oldFavoriteMovies = self.favoriteMovies.compactMap { $0.id }
        let newFavoriteMovies = PersistenceService.favoriteMovies
        if newFavoriteMovies.count > oldFavoriteMovies.count {
            let newSet = Set(newFavoriteMovies)
            let oldSet = Set(oldFavoriteMovies)
            return Array(newSet.symmetricDifference(oldSet))
        }
        return []
    }
    
    private func setSearch() {
        if !self.searchTerm.isEmpty && self.state != .withoutNetwork {
            self.filteredMovies = self.favoriteMovies.filter { $0.title.lowercased().contains(self.searchTerm.lowercased()) }
            self.state = self.filteredMovies.isEmpty ? .searchNoData : .search
        } else if self.firstRequest == false {
            self.state = .loaded
        }
    }

}
