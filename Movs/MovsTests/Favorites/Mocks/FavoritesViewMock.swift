//
//  FavoritesViewMock.swift
//  MovsTests
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxTest

@testable import Movs

class FavoritesViewMock: FavoritesViewModelInput, FavoritesViewModelOutput {
    let contentRequest: TestableObservable<Void>
    let removeRequest: TestableObservable<FavoriteMovieViewModel>
    let movies: TestableObserver<[FavoriteMovieViewModel]>
    let disposeBag = DisposeBag()

    init(scheduler: TestScheduler,
         triggerEvents: [Recorded<Event<Void>>],
         removeEvents: [Recorded<Event<FavoriteMovieViewModel>>]) {

        movies = scheduler.createObserver([FavoriteMovieViewModel].self)
        contentRequest = scheduler.createColdObservable(triggerEvents)
        removeRequest = scheduler.createColdObservable(removeEvents)
    }

    func loadTrigger() -> Observable<Void> {
        return contentRequest.asObservable()
    }

    func remove() -> Observable<FavoriteMovieViewModel> {
        return removeRequest.asObservable()
    }

    func favorites(_ driver: Driver<[FavoriteMovieViewModel]>) {
        driver.drive(movies)
              .disposed(by: disposeBag)
    }
}
