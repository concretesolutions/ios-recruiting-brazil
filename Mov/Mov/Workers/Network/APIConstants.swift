//
//  NetworkConstants.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct kAPI {
    struct TMDB {
        public static let basePath = URL(string: "https://api.themoviedb.org/3/")!
        public static let key = "eb8f32bbe0d7f957729c0f26080650dc"
        public static let keyParamKey = "api_key"
        public static let sortParamKey = "sort_by"
        public static let pageParamKey = "page"
        
        public static let popularityDescParamValue = "popularity.desc"
        
        public static var decoder: JSONDecoder {
            let decoder = JSONDecoder()
            
            // convert from api snake-case keys to camelCase
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // set date format to match api date format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            return decoder
        }
    }
}
