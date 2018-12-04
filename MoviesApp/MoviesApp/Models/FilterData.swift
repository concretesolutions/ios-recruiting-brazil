//
//  FilterData.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

struct Filter {
    var genre: Genre?
    var date: Date?
    
    private func isSame(date movieDate: Date) -> Bool {
        guard let date = date else {
            return true
        }
        let calendar = Calendar(identifier: .gregorian)
        return calendar.compare(date, to: movieDate, toGranularity: .year) == .orderedSame
    }
    
    private func contains(genreIds: [Int]) -> Bool {
        guard let selectedGenre = genre else {
            return true
        }
        return genreIds.contains(where: { (value) -> Bool in
            return value == selectedGenre.id
        })
    }
    
    func filter(movies: [Movie]) -> [Movie] {
        return movies.filter {
            return isSame(date: $0.releaseDate) && contains(genreIds: $0.genreIds)
        }
    }
}
