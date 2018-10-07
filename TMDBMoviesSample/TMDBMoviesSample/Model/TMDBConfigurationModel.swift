//
//  TMDBConfigurationModel.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 06/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class TMDBConfigurationModel: Codable {
    let images: TMDBImageConfiguration?
}

class TMDBImageConfiguration: Codable {

    var baseURL: String?
    var safeBaseURL: String?
    var backdropSizes: [String]?
    var posterSizes: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case baseURL        = "base_url"
        case safeBaseURL    = "secure_base_url"
        case backdropSizes  = "backdrop_sizes"
        case posterSizes    = "poster_sizes"
    }
}
