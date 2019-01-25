//
//  TheMovieDBConfigProvider.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class TheMovieDBConfigProvider: ConfigProvider {
    let provider = MoyaProvider<TheMovieDBAPI>()

    func config() -> Observable<TheMovieDBConfig> {
        return provider.rx.request(.configuration)
                          .map(TheMovieDBConfig.self)
                          .asObservable()
    }

    func genres() -> Observable<GenresResponse> {
        return provider.rx.request(.genres)
                          .map(GenresResponse.self)
                          .asObservable()
    }

}
