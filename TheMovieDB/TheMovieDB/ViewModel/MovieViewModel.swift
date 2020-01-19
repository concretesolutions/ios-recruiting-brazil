//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MovieViewModel {
    public static let shared = MovieViewModel.init()
    public var movies: [Movie] = [] {
        didSet {
            NotificationCenter.default.post(.moviesUpdated)
        }
    }
    
    public var filteredMovies: [Movie] = []
    
    public var selectedMovie: Movie?
    
    private var pathURLMovies: String {
        get {
            return  "\(ServiceAPIManager.PathsAPI.rootAPI)\(ServiceAPIManager.PathsAPI.versionAPI)\(ServiceAPIManager.PathsAPI.MovieAPI.movie)"
        }
    }
    
    private init() { }
    
    public func selectMovie(index: Int, isFiltered: Bool = false) {
        guard index >= 0 else { return }
        if isFiltered {
            self.selectedMovie = filteredMovies[index]
        } else {
            self.selectedMovie = movies[index]
        }
    }
    
    public func changeFavorite(at index: Int? = nil) {
        if let changeIndex = index {
            let movie = movies.filter({ $0.isFavorite })[changeIndex]
            movie.isFavorite = !movie.isFavorite
            movie.notification.send()
        } else {
            guard let movie = selectedMovie else { return }
            movie.isFavorite = !movie.isFavorite
            movie.notification.send()
        }
    }
    
    public func delete(at index: Int) {
        movies.remove(at: index)
    }
    
    public func filterMovies(withText text: String) {
        filteredMovies = movies.filter { (movie) -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
    }
    
    public func fetchMovies() {
        guard var components = URLComponents.init(string: pathURLMovies) else { return }
        components.queryItems = [
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.apiKey, value: ServiceAPIManager.PathsAPI.key),
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
