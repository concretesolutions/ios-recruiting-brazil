//
//  FavoritesViewModelSpec.swift
//  MovsTests
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxTest

@testable import Movs

class FavoritesViewModelSpec: QuickSpec {
    override func spec() {
        describe("When creating a FavoritesViewModel") {
            let genresMock = [MovsGenre(identifier: 1, name: "terror"),
                              MovsGenre(identifier: 2, name: "Drama"),
                              MovsGenre(identifier: 3, name: "Comedia")]

            let configMock = MovsConfig(imageProvider: URL(string: "https://google.com.br")!, genres: genresMock)

            context("And there are no favorites") {
                let storeMock = FavoriteStoreMock(movies: [])

                let scheduler = TestScheduler(initialClock: 0)

                let viewMock = FavoritesViewMock(scheduler: scheduler,
                                                 triggerEvents: [.next(10, Void()), .next(50, Void())],
                                                 removeEvents: [])

                _ = FavoritesViewModel(view: viewMock, favoriteStore: storeMock, config: configMock)

                scheduler.start()

                it("Should output two empty lists of viewmodels") {
                    let times = viewMock.movies.events.map { $0.time }
                    expect(times).to(equal([10, 50]))

                    let values = viewMock.movies.events.compactMap { $0.value.event.element }
                    values.forEach({ val in
                        expect(val).to(beEmpty())
                    })
                }
            }
        }
    }
}
