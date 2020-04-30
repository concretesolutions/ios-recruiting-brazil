//
//  FavoriteFilter.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 28/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

class FavoriteFilters: Codable {

    public private(set) var keyword: String?
    public private(set) var year: Int?

    public private(set) var genre: Genre?

    func search(with keyword: String?) {
        self.keyword = keyword
    }

    func setReleased(in year: String) {
        self.year = Int(year)
    }

    func setGenre(named genreName: String, using genres: [Genre]) {
        self.genre = genres.first(where: { $0.name == genreName })
    }

    func appyFilters() {
        mainStore.dispatch(FavoriteThunk.search(filteringBy: self))
    }

    func clear() {
        self.keyword = nil
        self.genre = nil
        self.year = nil

        self.appyFilters()
    }

    func clone() throws -> FavoriteFilters {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONDecoder().decode(FavoriteFilters.self, from: jsonData)
    }

    var isEmpty: Bool {
        return self.genre == nil && self.keyword == nil && self.year == nil
    }
}

extension FavoriteFilters: Equatable {
    static func == (lhs: FavoriteFilters, rhs: FavoriteFilters) -> Bool {
        return lhs.keyword == rhs.keyword
            && lhs.year == rhs.year
            && lhs.genre == rhs.genre
    }
}
