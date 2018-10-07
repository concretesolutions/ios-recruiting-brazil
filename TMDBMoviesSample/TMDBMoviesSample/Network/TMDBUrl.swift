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
        var queryItems: [URLQueryItem] = []
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        queryItems.append(apiKeyQueryItem)
        
        if let page = page {
            let pageQueryItem = URLQueryItem(name: "page", value: String(page))
            queryItems.append(pageQueryItem)
        }
        
        if let languageCode = Locale.current.languageCode {
            let languageQueryItem = URLQueryItem(name: "language", value: languageCode)
            queryItems.append(languageQueryItem)
        }
        
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    private func getUrlString(to endpoint: EndPoints) -> String {
        return baseUrl + endpoint.rawValue
    }
}

enum EndPoints {
    
    case moviesList
    case configuration
    
    var rawValue: String {
        switch self {
        case .moviesList:
            return "/movie/popular"
        case .configuration:
            return "/configuration"
        }
    }
}
