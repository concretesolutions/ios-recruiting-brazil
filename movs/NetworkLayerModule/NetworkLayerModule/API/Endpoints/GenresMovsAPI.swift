//
//  GenresMovsAPI.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

public enum GenresMovsAPI: MtdbAPI {
    case normal
}

extension GenresMovsAPI {    
    public var path: String {
        return "3/genre/movie/list"
    }
}
