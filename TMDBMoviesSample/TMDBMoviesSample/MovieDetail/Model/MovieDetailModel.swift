//
//  MovieDetailModel.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieDetailModel: Codable {
    let title: String
    let releaseYear: String
    let genreIds: [Int]
    let description: String
    let posterData: Data
    let id: Int
    var isFav: Bool = false
    
    init(title: String, releaseYear: String, genreIds: [Int], description: String, posterData: Data, id: Int) {
        self.title = title
        self.releaseYear = releaseYear
        self.genreIds = genreIds
        self.description = description
        self.posterData = posterData
        self.id = id
    }
}

extension MovieDetailModel: Equatable {
    static func == (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        return lhs.title == rhs.title
    }
}
