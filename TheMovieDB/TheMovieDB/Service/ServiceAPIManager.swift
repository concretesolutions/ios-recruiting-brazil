//
//  ServiceAPIManager.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

class ServiceAPIManager {
    struct PathsAPI {
        public static let key = "6192cea18be6726e8bf48424e7b43b27"
        public static let https = "https://"
        public static let rootAPI = "api.themoviedb.org"
        public static let versionAPI = "/3"
        public static let api_key = "api_key"
        public static let language = "language"
        public static let page = "page"
        
        struct MovieAPI {
            public static let movie = "/movie"
            public static let popular = "/popular"
        }
        
        public static func getKeyPath() -> String {
            return "\(PathsAPI.api_key)\(PathsAPI.key)"
        }
    }
    
    public static let session = URLSession(configuration: .default)
    
    public static func get(url: URL, completition: @escaping (_ data: Data?, _ error: Error?) -> Void ) {
        session.dataTask(with: url) { (data, response, error) in
            completition(data, error)
        }.resume()
    }
}
