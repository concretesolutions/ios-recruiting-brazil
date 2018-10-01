//
//  MockMovieDetailService.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RxSwift

@testable import ios_recruiting_brazil

final class MockMovieDetailService: MovieDetailServiceType {
    
    var callRemoveMethod = false
    var callSaveMethod = false
    var fetchMovieInRealmSuccess = true
    var fetchGenderSuccess = true
    
    private var provider = RequestMockProvider<MovieDetailTargetTypeMock>()
    
    func fetGender() -> Observable<[GenderModel]> {
        if fetchGenderSuccess {
            return self.provider.requestArray(MovieDetailTargetTypeMock.genders)
        } else {
            return self.provider.requestArray(MovieDetailTargetTypeMock.gendersError)
        }
    }
    
    func fentMovieInRealm(id: Int) -> MovieModel? {
        if fetchMovieInRealmSuccess {
            return MovieModel(id: 272,
                              posterPath: "/65JWXDCAfwHhJKnDwRnEgVB411X.jpg",
                              title: "Batman Begins",
                              desc: "Batman Begins",
                              releaseDate: "2005-06-10",
                              releaseYear: "2005",
                              genders: [GenderModel(id: 28)],
                              isFavorite: true)
        } else {
            return nil
        }
    }
    
    func removeMovie(id: Int) {
        self.callRemoveMethod = true
    }
    
    func save(movie: MovieModel) {
        self.callSaveMethod = true
    }
    
    
}
