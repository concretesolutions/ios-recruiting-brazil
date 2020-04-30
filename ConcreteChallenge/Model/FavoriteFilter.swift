//
//  FavoriteFilter.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 28/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

class FavoriteFilters: Codable, Equatable {
    static func == (lhs: FavoriteFilter, rhs: FavoriteFilter) -> Bool {
        return lhs.keyword == rhs.keyword
            && lhs.year == rhs.year
            && lhs.genre == rhs.genre
    }

    public private(set) var keyword: String?
    public private(set) var year: Int?
    public private(set) var genre: Genre?

    func setReleased(in year: String) {
        self.year = Int(year)
    }

    func search(by keyword: String) {
        self.keyword = keyword
    }

    func setGenre(named genreName: String, using genres: [Genre]) {
        self.genre = genres.first(where: { $0.name == genreName })
    }

    func applyFilters() {
        mainStore.dispatch(FavoriteThunk.search(filteringBy: self))
    }

    func clone() throws -> Movie {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONDecoder().decode(Movie.self, from: jsonData)
    }

}
