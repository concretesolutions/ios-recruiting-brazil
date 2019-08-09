//
//  MovieDetailsDataReleaseDate.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct DataReleaseDate {
    var releaseDate:Date
    var releaseYear:Int
    
    init(releaseDate:Date, releaseYear:Int) {
        self.releaseDate = releaseDate
        self.releaseYear = releaseYear
    }
}

extension DataReleaseDate : Decodable {
    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let releaseDateDecodable = try container.decode(Date.self, forKey: .releaseDate)
 
        self.init(releaseDate: releaseDateDecodable, releaseYear: releaseDateDecodable.Year())
    }
}
