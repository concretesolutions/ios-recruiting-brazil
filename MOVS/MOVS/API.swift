//
//  APIProtocol.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 20/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

protocol API {
    var base: String { get }
    var path: String { get }
    var page: Int { get set }
    var query: String? {get set }
}

extension API {
    var apiKey: URLQueryItem {
        return URLQueryItem(name: "api_key", value: "e192c87c472cd9275a61a302ff860803")
    }
    
    var language: URLQueryItem{
        return URLQueryItem(name: "language", value: "pt-BR")
    }
    
    var pageURL: URLQueryItem{
        return URLQueryItem(name: "page", value: "\(page)")
    }
    
    var queryURL: URLQueryItem? {
        if let zquery = query {
            return URLQueryItem(name: "query", value: "\(zquery)")
        }
        return nil
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        if let zquery = queryURL {
            components.queryItems = [apiKey, language, pageURL, zquery]
        }else{
            components.queryItems = [apiKey, language, pageURL]
        }
        return components
    }
    
    var requestMovies: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
