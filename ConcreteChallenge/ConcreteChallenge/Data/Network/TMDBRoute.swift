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
    
    private static var apiKey = "4b8d40349182e03ae8e2f6fd304c9aee"
    
    // the associetedValue is the page
    case popular(Int?)
    case similar(Int?, Int)
    case image(String)
    case genres
    case searchMovies(String, Int?)
    
    var baseURL: URL {
        switch  self {
        case .popular, .genres, .searchMovies, .similar:
            return URL(string: "https://api.themoviedb.org/")!
        case .image:
            return URL(string: "http://image.tmdb.org/")!
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/upcoming"
        case .image(let imagePath):
            return "/t/p/w780/\(imagePath)"
        case .genres:
            return "/3/genre/movie/list"
        case .searchMovies:
            return "/3/search/movie"
        case .similar(_, let movieID):
            return "/3/movie/\(movieID)/similar"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var urlParams: [URLQueryItem] {
        
        switch self {
        case .popular(let pageNumber):
            let pageNumber = pageNumber ?? 1
            return [
                .init(tmdbProperty: .apiKey, value: TMDBMoviesRoute.apiKey),
                .init(tmdbProperty: .pageNumber, value: String(pageNumber))
            ]
        case .image:
            return []
        case .genres:
            return [
                .init(tmdbProperty: .apiKey, value: TMDBMoviesRoute.apiKey),
            ]
        case .searchMovies(let query, let pageNumber):
            let pageNumber = pageNumber ?? 1
            return [
                .init(tmdbProperty: .apiKey, value: TMDBMoviesRoute.apiKey),
                .init(tmdbProperty: .query, value: query),
                .init(tmdbProperty: .pageNumber, value: String(pageNumber))
            ]
        case .similar(let pageNumber, _):
            let pageNumber = pageNumber ?? 1
            return [
                .init(tmdbProperty: .apiKey, value: TMDBMoviesRoute.apiKey),
                .init(tmdbProperty: .pageNumber, value: String(pageNumber))
            ]
        }
    }
}
