//
//  TheMovieDBDataProvider.swift
//  Movs
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesProvider {
    func topMovies(page: Int) -> Observable<MoviesPage>
}
