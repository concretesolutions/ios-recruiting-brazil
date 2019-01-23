//
//  MovieListViewMock.swift
//  MovsTests
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxTest

@testable import Movs

class MovieListViewMock: MoviesDisplayer & MoviesViewModelActuator {
    let errors: TestableObserver<Void>
    let triggers: TestableObservable<Void>
    let movies: TestableObserver<[MovieViewModel]>
    let disposeBag: DisposeBag

    init(scheduler: TestScheduler, disposeBag: DisposeBag, triggerEvents: [Recorded<Event<Void>>]) {
        errors = scheduler.createObserver(Void.self)
        movies = scheduler.createObserver([MovieViewModel].self)
        triggers = scheduler.createColdObservable(triggerEvents)
        self.disposeBag = disposeBag
    }

    func trigger() -> Driver<Void> {
        return triggers.asDriver(onErrorJustReturn: Void())

    }

    func display(error: Driver<Void>) {
        error.asObservable()
            .bind(to: errors)
            .disposed(by: disposeBag)
    }

    func display(movies: Driver<[MovieViewModel]>) {
        movies.asObservable()
            .bind(to: self.movies)
            .disposed(by: disposeBag)
    }
}
