//
//  PupolarMoviesGridService.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol PupolarMoviesGridServiceType {
    func fetchMovies(target: MoviesTargetType) -> Observable<ResponsePopularMovies>
}

final class PupolarMoviesGridService: PupolarMoviesGridServiceType {
    
    // MARK: Private Variables
    private var provider: RequestProvider<MoviesTargetType>
    
    init(provider: RequestProvider<MoviesTargetType> = RequestProvider<MoviesTargetType>()) {
        self.provider = provider
    }
    
    func fetchMovies(target: MoviesTargetType) -> Observable<ResponsePopularMovies> {
        return self.provider.requestObject(target)
    }
}
