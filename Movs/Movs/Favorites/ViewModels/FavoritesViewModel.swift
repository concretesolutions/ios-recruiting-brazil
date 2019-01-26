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
    func loadTrigger() -> Observable<Void>
    func remove() -> Observable<FavoriteMovieViewModel>
}

protocol FavoritesViewModelOutput {
    func favorites(_ driver: Driver<[FavoriteMovieViewModel]>)
}

class FavoritesViewModel {
    typealias View = FavoritesViewModelInput & FavoritesViewModelOutput
    private let disposeBag = DisposeBag()

    private let view: View
    private let store: FavoriteStore
    private let config: MovsConfig

    init(view: View, favoriteStore: FavoriteStore, config: MovsConfig) {
        self.store = favoriteStore
        self.view = view
        self.config = config
        setupRemoval()
        setupBind()
    }

    func setupBind() {
        let favorites = requestMovies()
                        .map(viewModels)
                        .asDriver { _ -> Driver<[FavoriteMovieViewModel]> in return Driver.empty() }

        view.favorites(favorites)
    }

    func setupRemoval() {
        view.remove()
            .map { $0.model }
            .subscribe(onNext: { [weak self] model in
                guard let strongSelf = self else { return }
                strongSelf.store.drop(movie: model)
            })
            .disposed(by: disposeBag)
    }

    func requestMovies() -> Observable<[Movie]> {
        let didRemove = view.remove().map { _ in Void() }

        return Observable
            .merge(view.loadTrigger(), didRemove)
            .flatMap { [weak self] _ -> Observable<[Movie]> in
                guard let strongSelf = self else { return Observable.empty() }
                let movies = strongSelf.store.fetch()
                return Observable.just(movies)
        }
    }

    func viewModels(from movies: [Movie]) -> [FavoriteMovieViewModel] {
        return movies.map { movie in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            let date = formatter.date(from: movie.releaseDate)
            let year = date.map { Calendar.current.component(.year, from: $0) }
                           .map(String.init) ?? ""

            return FavoriteMovieViewModel(model: movie,
                                          title: movie.title,
                                          year: year,
                                          image: movie.posterPath.map(config.imageUrl),
                                          overview: movie.overview) }
    }
}
