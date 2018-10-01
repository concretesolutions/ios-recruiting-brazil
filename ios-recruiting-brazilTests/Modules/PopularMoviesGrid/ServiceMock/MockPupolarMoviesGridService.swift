//
//  MockPupolarMoviesGridService.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RxSwift
import Moya

@testable import ios_recruiting_brazil

final class MockPupolarMoviesGridService: PupolarMoviesGridServiceType {
    
    private var provider = RequestMockProvider<PopularMoviesGridTartTypeMock>()
    
    func fetchMovies(target: MoviesTargetType) -> Observable<ResponsePopularMovies> {
        if target.path == "/3/movie/popular" {
            return self.provider.requestObject(PopularMoviesGridTartTypeMock.popularMovies)
        } else {
            return self.provider.requestObject(PopularMoviesGridTartTypeMock.filterMovies)
        }
    }
}
