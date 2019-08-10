//
//  SingletonProperties.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
class SingletonProperties {
    static let shared = SingletonProperties()
    var genres:[GenreData]?
    var favorites:[FavoritesDetailsData]?
    init() {}
}
