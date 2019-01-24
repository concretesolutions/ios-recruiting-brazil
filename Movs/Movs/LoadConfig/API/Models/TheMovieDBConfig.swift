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
    let baseURL: String
    let secureBaseURL: String
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
    }

    func safeImageURL(for image: String) -> URL? {
        return URL(string: "\(secureBaseURL)w500\(image)")
    }
}
