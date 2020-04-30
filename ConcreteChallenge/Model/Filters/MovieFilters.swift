//
//  MovieFilters.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 29/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

class MovieFilters: Codable {

    public private(set) var language: String = "pt-BR"
    public private(set) var query: String!
    public private(set) var page: Int = 1
    public private(set) var includeAdult: Bool?
    public private(set) var region: String?
    public private(set) var year: Int?
    public private(set) var primaryReleaseYear: Int?

    func search(for keyword: String?) {
        self.query = keyword
    }

    func setReleased(in year: String) {
        self.year = Int(year)
    }

    func setReleased(in year: Int?) {
        self.year = year
    }

    func setPrimaryReleased(in year: String) {
        self.primaryReleaseYear = Int(year)
    }

    func setPrimaryReleased(in year: Int?) {
        self.primaryReleaseYear = year
    }

    func setLanguage(iso language: String) {
        self.language = language
    }

    func setPage(to page: Int) {
        self.page = page
    }

    func includeAdult(_ includeAdult: Bool?) {
        self.includeAdult = includeAdult
    }

    func setRegion(to region: String?) {
        self.region = region
    }

    func resetPagination() {
        self.page = 1
    }

    func loadNextPage() {
        do {
            let clone = try self.clone()
            clone.setPage(to: clone.page + 1)
            clone.appyFilters()
        } catch {
            print("Error cloning MovieFilters")
        }
    }

    func clear() {
        self.language = "pt-BR"
        self.query = nil
        self.includeAdult = nil
        self.region = nil
        self.year = nil
        self.primaryReleaseYear = nil

        self.resetPagination()

        self.appyFilters()
    }

    var parameters: Parameters? {
        guard self.query != nil else { return nil }

        var params: Parameters = [
            "page": self.page,
            "language": self.language,
            "query": self.query!
        ]

        if self.includeAdult != nil {
            params["include_adult"] = self.includeAdult!.description
        }

        if self.region != nil {
            params["region"] = self.region!
        }

        if self.year != nil {
            params["year"] = self.year!
        }

        if self.primaryReleaseYear != nil {
            params["primaryReleaseYear"] = self.primaryReleaseYear!
        }

        return params
    }

    func appyFilters() {
        if self.query != nil {
            mainStore.dispatch(MovieThunk.search(filteringBy: self))
        } else {
            mainStore.dispatch(MovieThunk.fetchPopular(at: self.page))
        }
    }

    func clone() throws -> MovieFilters {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONDecoder().decode(MovieFilters.self, from: jsonData)
    }

    var isEmpty: Bool {
        return self.query == nil
    }
}

extension MovieFilters: Equatable {
    static func == (lhs: MovieFilters, rhs: MovieFilters) -> Bool {
        return lhs.language == rhs.language
            && lhs.query == rhs.query
            && lhs.page == rhs.page
            && lhs.includeAdult == rhs.includeAdult
            && lhs.region == rhs.region
            && lhs.year == rhs.year
            && lhs.primaryReleaseYear == rhs.primaryReleaseYear

    }
}
