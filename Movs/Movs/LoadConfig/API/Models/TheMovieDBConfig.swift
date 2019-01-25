//
//  TheMovieDBConfig.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

struct TheMovieDBConfig: Codable {
    let images: Images
}

struct Images: Codable {
    let baseURL: URL
    let secureBaseURL: URL
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
    }
}
