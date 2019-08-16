//
//  FavoriteMoviesViewModel.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 14/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import os

public protocol FavoriteMoviesViewModelable: Registrable, FilterDelegate {
    var presentationState: Observable<FavoriteMoviesPresentationState> { get set }
    var favoritedMovies: Observable<[Movie]> { get }
    var filteredMovies: Observable<[Movie]> { get }
    var reloadUI: Observable<Bool> { get }
    func initialize()
    func delete(movie: Movie) -> Bool
    func reloadData()
}

public enum FavoriteMoviesPresentationState {
    case withFilter
    case withoutFilter
}

public class FavoriteMoviesViewModel: FavoriteMoviesViewModelable {

    public var presentationState = Observable<FavoriteMoviesPresentationState>(.withoutFilter)
    public var favoritedMovies = Observable<[Movie]>([Movie]())
    public var filteredMovies = Observable<[Movie]>([Movie]())
    public var reloadUI = Observable<Bool>(false)

    public func initialize() {
        presentationState.bind { state in
            switch state {
            case .withFilter:
                self.reloadUI.value = true
            case .withoutFilter:
                self.getFavoriteMovies()
                self.reloadUI.value = true
            }
        }
    }

    public func reloadData() {
        getFavoriteMovies()
    }

    func getFavoriteMovies() {
        var updatedFavoritedMovies = [Movie]()
        let favoriteMoviesRealm = RealmManager.shared.getAll(objectsOf: MovieRealm.self)
        favoriteMoviesRealm?.forEach({ updatedFavoritedMovies.append(Movie(realmObject: $0)) })
        self.favoritedMovies.value = updatedFavoritedMovies
    }

    public func delete(movie: Movie) -> Bool {
        if let movieToDelete = RealmManager.shared.get(objectOf: MovieRealm.self, with: movie.id) {
            RealmManager.shared.delete(object: movieToDelete)
            return true
        }
        os_log(.error, log: .general, "Couldn't delete movie")
        return false
    }
}

extension FavoriteMoviesViewModel: FilterDelegate {

    public func updateMovies(with filteredMovies: [Movie]) {
        guard !favoritedMovies.value.isEmpty else {
            return
        }
        self.presentationState.value = .withFilter
        self.filteredMovies.value = filteredMovies
    }
}
