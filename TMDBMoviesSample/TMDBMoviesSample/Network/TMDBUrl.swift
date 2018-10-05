//
//  EndPoints.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

struct TMDBUrl {
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    
    func getUrl(to endpoint: EndPoints, and page: Int? = nil) -> URL? {
        var urlComponents = URLComponents(string: getUrlString(to: endpoint))
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        urlComponents?.queryItems?.append(apiKeyQueryItem)
        
        if let page = page {
            let pageQueryItem = URLQueryItem(name: "page", value: String(page))
            urlComponents?.queryItems?.append(pageQueryItem)
        }
        
        if let languageCode = Locale.current.languageCode {
            let languageQueryItem = URLQueryItem(name: "language", value: languageCode)
            urlComponents?.queryItems?.append(languageQueryItem)
        }
        
        return urlComponents?.url
    }
    
    private func getUrlString(to endpoint: EndPoints) -> String {
        return baseUrl + endpoint.rawValue
    }
}

enum EndPoints {
    
    case moviesList
    
    var rawValue: String {
        switch self {
        case .moviesList:
            return "/movie/popular"
        }
    }
}
