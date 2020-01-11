//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {
    public static let shared = MovieViewModel.init()
    public var movies = [Movie]() {
        didSet {
            NotificationCenter.default.post(.moviesUpdated)
        }
    }
    private var pathURLMovies: String {
        get {
            return  "\(ServiceAPIManager.PathsAPI.https)\(ServiceAPIManager.PathsAPI.rootAPI)\(ServiceAPIManager.PathsAPI.versionAPI)\(ServiceAPIManager.PathsAPI.MovieAPI.movie)\(ServiceAPIManager.PathsAPI.MovieAPI.popular)"
        }
    }
    
    private init() { }
    
    public func fetchMovies() {
        let path = pathURLMovies
        guard var components = URLComponents.init(string: path) else { return }
        components.queryItems = [
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.api_key, value: ServiceAPIManager.PathsAPI.key),
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.page, value: "1")
        ]
        guard let url = components.url else { return }
        ServiceAPIManager.get(url: url) { (data, error)  in
            guard let result = data else { return }
            do {
                let moviesDecode = try JSONDecoder().decode(PopularMoviesAPI.self, from: result)
                self.movies = moviesDecode.movies
            } catch { }
        }
    }
}
