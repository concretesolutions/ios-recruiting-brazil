//
//  APISettings.swift
//  movs
//
//  Created by Isaac Douglas on 23/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import Foundation

struct APISettings: Codable {
    let url: String
    let apiKey: String
    
    static var shared: APISettings?
    
    enum CodingKeys: String, CodingKey {
        case url
        case apiKey = "api_key"
    }
}

extension APISettings {
    func genre() -> URL? {
        return URL(string: "\(self.url)/genre/movie/list?api_key=\(self.apiKey)")
    }
    
    func popular(page: Int = 1) -> URL? {
        return URL(string: "\(self.url)/movie/popular?api_key=\(self.apiKey)&page=\(page)")
    }
}
