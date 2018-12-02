//
//  Configuration.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation

struct Configuration: Codable {
    let images: Images
}

struct Images: Codable {
    
    let baseURL: String
    let posterSizes: [String]
    
    private enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case posterSizes = "poster_sizes"
    }
}

class APISettings {
    static let shared = APISettings()
    
    var configuration: Configuration?
    let client = MovieAPIClient()
    
    private init() {
        client.fetchConfiguration { config in
            print(config)
            self.configuration = config
        }
    }
}
