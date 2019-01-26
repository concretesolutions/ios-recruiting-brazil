//
//  TheMovieDBDataProvider.swift
//  Movs
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class TheMovieDBProvider: MoviesProvider {
    let provider = MoyaProvider<TheMovieDBAPI>()

    func topMovies(page: Int) -> Observable<MoviesPage> {
        return provider.rx.request(.top(page: page))
                          .map(MoviesPage.self)
                          .asObservable()
    }
}
