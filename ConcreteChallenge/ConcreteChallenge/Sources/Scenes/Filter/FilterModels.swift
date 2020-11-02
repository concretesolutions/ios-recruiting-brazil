//
//  FilterModels.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Filter {
    enum FetchDates {
        struct ViewModel {
            let dates: [String]
        }

        struct Response {
            let dates: [String]
        }
    }

    enum FetchGenres {
        struct Request {
            let language: String
        }

        struct Response {
            let genres: [String]
        }

        struct ViewModel {
            let genres: [String]
        }
    }
}
