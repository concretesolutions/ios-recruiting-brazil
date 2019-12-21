//
//  URLQueryItem+initWithTMDBQueryProperty.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

extension URLQueryItem {

    //A init for creating a URLQueryItem using a TMDBQueryProperty
    init(tmdbProperty: TMDBQueryProperty, value: String) {
        self.init(name: tmdbProperty.rawValue, value: value)
    }
}
