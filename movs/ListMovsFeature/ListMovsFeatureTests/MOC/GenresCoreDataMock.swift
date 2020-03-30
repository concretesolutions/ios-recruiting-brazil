//
//  GenresCoreDataMock.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import GenresFeature
import NetworkLayerModule

class GenresCoreDataMock: GenresFeatureServiceType {
    func fetchGenres(handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void) {
        handle(.success([
                GenreModel(id: 0, name: "Zero"),
                GenreModel(id: 1, name: "One")
            ]))
    }
    
    func genre(by ids: [Int], handle: @escaping (Result<[GenreModel], MtdbAPIError>) -> Void) {
        handle(.success([
            GenreModel(id: 0, name: "Zero"),
            GenreModel(id: 1, name: "One")
        ]))
    }
    
    
}
