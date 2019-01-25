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
    func trigger() -> Driver<Void>
}

protocol MoviesViewModelOutput: class {
    func display(error: Driver<Void>)
    func display(movies: Driver<[MovieViewModel]>)
}

class MovieListViewModel {
    private let page = BehaviorSubject(value: 1)
    private let dataProvider: MoviesProvider
    private let disposeBag = DisposeBag()

    private weak var view: (MoviesViewModelInput & MoviesViewModelOutput)?
    private let config: MovsConfig

    init(view: MoviesViewModelInput & MoviesViewModelOutput, dataProvider: MoviesProvider, config: MovsConfig) {
        self.dataProvider = dataProvider
        self.view = view
        self.config = config
        setupBinds()
    }

    func setupBinds() {
        guard let view = view else { return }
        let pages = requestPage(trigger: view.trigger().asObservable())

        setupPaging(with: pages)

        let moviesDriver = pages.map { $0.results }
            .map { $0.map(self.movieViewModel)}
            .scan([MovieViewModel](), accumulator: +)
            .asDriver(onErrorJustReturn: [])

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
        
        return MovieViewModel(model: movie, title: movie.title, image: config.imageUrl(movie.posterPath))
    }
}
