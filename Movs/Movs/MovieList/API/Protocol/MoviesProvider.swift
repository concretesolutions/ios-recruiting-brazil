//
//  MoviesProvider.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import RxSwift

protocol MoviesProvider {
    func topMovies(page: Int) -> Observable<MoviesPage>
}
