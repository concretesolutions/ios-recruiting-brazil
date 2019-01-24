//
//  MovieListViewModelSpec.swift
//  MovsTests
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Quick
import Nimble

import RxBlocking
import RxSwift
import RxTest
import RxCocoa
import Moya
@testable import Movs

class MovieListViewModelSpec: QuickSpec {
    override func spec() {

        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)

        let viewMock = MovieListViewMock(scheduler: scheduler,
                                         disposeBag: disposeBag,
                                         triggerEvents: [.next(10, Void()),
                                                         .next(20, Void())])

        let pages = [MoviesPage(page: 1, totalResults: 3, totalPages: 3, results: [Movie(voteCount: 0,
                                                                                         identifier: 0,
                                                                                         video: false,
                                                                                         voteAverage: 1.0,
                                                                                         title: "Moviee",
                                                                                         popularity: 1.0,
                                                                                         posterPath: "path",
                                                                                         originalLanguage: "",
                                                                                         originalTitle: "",
                                                                                         genreIDS: [],
                                                                                         backdropPath: "",
                                                                                         adult: false,
                                                                                         overview: "",
                                                                                         releaseDate: "")]),
                     MoviesPage(page: 2, totalResults: 3, totalPages: 3, results: [Movie(voteCount: 0,
                                                                                         identifier: 0,
                                                                                         video: false,
                                                                                         voteAverage: 1.0,
                                                                                         title: "Moviee",
                                                                                         popularity: 1.0,
                                                                                         posterPath: "path",
                                                                                         originalLanguage: "",
                                                                                         originalTitle: "",
                                                                                         genreIDS: [],
                                                                                         backdropPath: "",
                                                                                         adult: false,
                                                                                         overview: "",
                                                                                         releaseDate: "")]),
                     MoviesPage(page: 3, totalResults: 3, totalPages: 3, results: [Movie(voteCount: 0,
                                                                                         identifier: 0,
                                                                                         video: false,
                                                                                         voteAverage: 1.0,
                                                                                         title: "Moviee",
                                                                                         popularity: 1.0,
                                                                                         posterPath: "path",
                                                                                         originalLanguage: "",
                                                                                         originalTitle: "",
                                                                                         genreIDS: [],
                                                                                         backdropPath: "",
                                                                                         adult: false,
                                                                                         overview: "",
                                                                                         releaseDate: "")])]
        let dataProviderMock = MoviesProviderSuccessMock(pages: pages)
        _ = MovieListViewModel(view: viewMock, dataProvider: dataProviderMock)

        scheduler.start()
        it("") {
            expect(viewMock.movies.events.count).to(equal(2))
            expect(viewMock.errors.events.count).to(equal(2))
        }
    }
}
