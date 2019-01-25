//
//  MovieListViewModel.swift
//  Movs
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol MoviesViewModelInput: class {
    func requestUpdate() -> Driver<Void>
    func requestContent() -> Driver<Void>
}

protocol MoviesViewModelOutput: class {
    func display(error: Driver<Void>)
    func display(movies: Driver<[MovieViewModel]>)
}

class MovieListViewModel {
    typealias View = MoviesViewModelInput & MoviesViewModelOutput
    private let page = BehaviorSubject(value: 1)
    private let dataProvider: MoviesProvider
    private let favoriteStore: FavoriteStore
    private let disposeBag = DisposeBag()

    private weak var view: View?
    private let config: MovsConfig

    init(view: View, dataProvider: MoviesProvider, config: MovsConfig, favoriteStore: FavoriteStore) {
        self.dataProvider = dataProvider
        self.favoriteStore = favoriteStore
        self.view = view
        self.config = config
        setupBinds()
    }

    func setupBinds() {
        guard let view = view else { return }
        let pages = requestPage(trigger: view.requestContent().asObservable())

        pages.subscribe(onNext: { page in
            page.results.forEach(self.favoriteStore.update)
        })
        .disposed(by: disposeBag)

        setupPaging(with: pages)

        let movies = pages.map { $0.results }
            .map { $0.map(self.movieViewModel)}
            .scan([MovieViewModel](), accumulator: +)

        let favorites = view.requestUpdate()
                            .asObservable()
                            .map(favoriteStore.fetch)

        let moviesDriver = Observable.combineLatest(movies, favorites)
                                    .map(setFavorite)
                                    .asDriver { _ in Driver<[MovieViewModel]>.empty() }

        let errorsDriver = pages.materialize()
            .filter { event in
                if case .error = event {
                    return true
                }
                return false
            }
            .dematerialize()
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: Void())

        view.display(error: errorsDriver)
        view.display(movies: moviesDriver)
    }

    func requestPage(trigger: Observable<Void>) -> Observable<MoviesPage> {
        return page.sample(trigger)
            .flatMap(dataProvider.topMovies)
    }

    func setupPaging(with pages: Observable<MoviesPage>) {
        pages.map(nextPage)
            .filter {$0 != nil}
            .map { $0 ?? 0 }
            .catchErrorJustReturn((try? page.value()) ?? 0)
            .bind(to: page)
            .disposed(by: disposeBag)
    }

    func nextPage(from page: MoviesPage) -> Int? {
        if page.page < page.totalPages {
            return page.page + 1
        } else {
            return nil
        }
    }

    func movieViewModel(from movie: Movie) -> MovieViewModel {
        let isFavorite = favoriteStore.contains(movie: movie)

        return MovieViewModel(model: movie,
                              title: movie.title,
                              image: config.imageUrl(movie.posterPath),
                              isFavorite: isFavorite)
    }

    func setFavorite(viewModels: [MovieViewModel], favorites: [Movie]) -> [MovieViewModel] {
        return
            viewModels.map { vm in
                let isFavorite = favoriteStore.contains(movie: vm.model)
                return MovieViewModel(model: vm.model,
                                      title: vm.title,
                                      image: vm.image,
                                      isFavorite: isFavorite)
            }
    }
}
