//
//  Router.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

enum Router {
    case getMoviesGenres
    case getFeaturedMovies(Int)
    
    /// The apiKey for each route
    var apiKey: String {
        return AppConstants.API.key
    }
    
    /// The base url  for each route
    var url: String {
        return AppConstants.API.baseUrl + AppConstants.API.apiVersion
    }
    
    /// The endpoint for each route
    var endpoint: String {
        switch self {
        case .getMoviesGenres:
            return AppConstants.Endpoints.moviesGenres
        case .getFeaturedMovies(_):
            return AppConstants.Endpoints.featuredMovies
        }
    }
    
    /// The method for each route
    var method: String {
        switch self {
        case .getMoviesGenres, .getFeaturedMovies(_):
            return "GET"
        }
    }
    
    /// The set of query strings for each route
    var parameters: [String: String] {
        var parameters = ["api_key" : apiKey]
        switch self {
        case .getFeaturedMovies(let page):
            parameters["page"] = page.description
        default:
            break
        }
        return parameters
    }
}
