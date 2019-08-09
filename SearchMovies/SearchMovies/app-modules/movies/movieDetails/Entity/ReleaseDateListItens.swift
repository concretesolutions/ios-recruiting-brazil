//
//  ReleaseDateListItens.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct ReleaseDateListItens {
    var id:Int
    var releases:[DataReleaseDate]
    
    init(id:Int, releases:[DataReleaseDate]) {
        self.id = id
        self.releases = releases
    }
}

extension ReleaseDateListItens : Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "iso_3166_1"
        case releases = "release_dates"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeDecodable = try container.decode(Int.self, forKey: .id)
        let releasesDecodable = try container.decode([DataReleaseDate].self, forKey: .releases)
        
        self.init(id:codeDecodable, releases: releasesDecodable)
    }
}
