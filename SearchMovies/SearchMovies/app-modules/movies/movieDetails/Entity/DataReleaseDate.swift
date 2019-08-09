//
//  MovieDetailsDataReleaseDate.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct DataReleaseDate {
    var releaseDate:String
    var releaseYear:Int
    
    init(releaseDate:String, releaseYear:Int) {
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
        let releaseDateDecodable = try container.decode(String.self, forKey: .releaseDate)
        let releaseYear:Int = releaseDateDecodable.toDate(format: Constants.jsonDateFormat).Year()
        self.init(releaseDate: releaseDateDecodable, releaseYear: releaseYear)
    }
}
