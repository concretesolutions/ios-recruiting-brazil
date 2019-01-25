//
//  FavoritesViewModel.swift
//  Movs
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritesViewModelInput {
    func triggers() -> Observable<Void>
}

protocol FavoritesViewModelOutput {
    func favorites(_ driver: Driver<[FavoriteMovieViewModel]>)
}

class FavoritesViewModel {
    typealias View = FavoritesViewModelInput & FavoritesViewModelOutput

    private let view: View
    private let store: FavoriteStore
    private let config: MovsConfig
    
    init(view: View, favoriteStore: FavoriteStore, config: MovsConfig) {
        self.store = favoriteStore
        self.view = view
        self.config = config

        setupBind()
    }

    func setupBind() {
        let favorites = requestMovies()
                        .map(viewModels)
                        .asDriver { _ -> Driver<[FavoriteMovieViewModel]> in return Driver.empty() }

        view.favorites(favorites)
    }

    func requestMovies() -> Observable<[Movie]> {
        return view.triggers()
            .flatMap { [weak self] _ -> Observable<[Movie]> in
                guard let strongSelf = self else { return Observable.empty() }
                let movies = strongSelf.store.fetch()
                return Observable.just(movies)
        }
    }

    func viewModels(from movies: [Movie]) -> [FavoriteMovieViewModel] {
        return movies.map { FavoriteMovieViewModel(model: $0,
                                                   title: $0.title,
                                                   year: $0.releaseDate,
                                                   image: config.imageUrl($0.posterPath),
                                                   overview: $0.overview) }
    }
}
