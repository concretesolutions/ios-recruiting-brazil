//
//  TheMovieDBSuccessMock.swift
//  MovsTests
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift

@testable import Movs

enum Erou: Error {
    case qualquer
}

class MoviesProviderSuccessMock: MoviesProvider {
    private let pages: [MoviesPage]

    init(pages: [MoviesPage]) {
        self.pages = pages
    }

    func topMovies(page: Int) -> Observable<MoviesPage> {
        if page == 2 {
            return Observable.error(Erou.qualquer)
        }
        return Observable.just(pages[page - 1])
    }
}
