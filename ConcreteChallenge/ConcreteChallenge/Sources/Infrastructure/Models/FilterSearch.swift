//
//  FilterSearch.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct FilterSearch {
    var search: String?
    var date: [String]?
    var genres: [String]?

    // MARK: - Initializers

    init(search: String? = nil, date: [String]? = nil, genres: [String]? = nil) {
        self.search = search
        self.date = date
        self.genres = genres
    }

    // MARK: - Computed variable

    var isEmpty: Bool {
        if let search = search, !search.isEmpty {
            return false
        } else if let date = date, date.count > 0 {
            return false
        } else if let genres = genres, genres.count > 0 {
            return false
        }

        return true
    }
}
