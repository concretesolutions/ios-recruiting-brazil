//
//  TMDBRoute.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

//The routes of the TMDB API
enum TMDBMoviesRoute: Route {
    case popular
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/")!
    }
    
    var path: String {
        return "/3/movie/upcoming"
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var urlParams: [URLQueryItem] {
        return [.init(tmdbProperty: .apiKey, value: "4b8d40349182e03ae8e2f6fd304c9aee")]
    }
}
