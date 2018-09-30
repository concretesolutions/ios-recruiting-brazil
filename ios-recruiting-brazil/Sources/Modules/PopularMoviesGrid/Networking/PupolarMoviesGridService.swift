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

final class PupolarMoviesGridService {
    
    // MARK: Private Variables
    private typealias Target = MoviesTargetType
    private var provider: RequestProvider<Target>
    
    init(provider: RequestProvider<MoviesTargetType>) {
        self.provider = provider
    }
    
    func getPopularMovies(page: Int) -> Observable<ResponsePopularMovies>{
        return self.provider.requestObject(Target.popularMovies(page))
    }
}
