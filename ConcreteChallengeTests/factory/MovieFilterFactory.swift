//
//  MovieFilterFactory.swift
//  ConcreteChallengeTests
//
//  Created by Erick Pinheiro on 30/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

@testable import ConcreteChallenge


class MovieFactory {

    let movieSearchQuery = "Movie Query"

    func getFullyFilledFilter() -> MovieFilters {
        let filters = MovieFilters()
        filters.search(for: movieSearchQuery)
        filters.setReleased(in: 2020)
        filters.setPrimaryReleased(in: 2021)
        filters.setLanguage(iso: "en-US")
        filters.setPage(to: 2)
        filters.includeAdult(true)
        filters.setRegion(to: "US")
        return filters
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }

    func generateMovie() -> Movie {
        return Movie(
            id: Int.random(in: 1..<100),
            posterPath: randomString(length: 50),
            adult: false,
            overview: randomString(length: 200),
            releaseDate: "2020-02-02",
            genreIds: [2, 3],
            genres: [randomString(length: 8), randomString(length: 8)],
            originalTitle: randomString(length: 8),
            originalLanguage: "pt-BR",
            title: randomString(length: 8),
            backdropPath: nil,
            video: false,
            popularity: Double.random(in: 1..<900),
            voteCount: Int.random(in: 600..<900),
            voteAverage: Double.random(in: 0..<10),
            favorited: false
        )
    }
    
}
