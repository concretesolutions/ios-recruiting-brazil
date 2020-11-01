//
//  FilterModels.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Filter {
    enum FetchGenres {
        struct Request {
            let language: String
        }

        struct Response {
            let genres: [GenreResponse]
        }

        struct ViewModel {
            let genres: [GenreResponse]
        }
    }
}
