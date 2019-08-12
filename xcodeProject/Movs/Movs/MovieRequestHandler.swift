//
//  MovieRequestHandler.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit

enum RequestModifier {
    case SEARCH
    case FILTER
    case FILTER_SEARCH
}

protocol MovieRequestListener {
    func onMoviesRequestFinished(_ fetchedMovies: Array<MovieObject>)
    func onMoviesRequestFinished(_ fetchedMovies: Array<MovieObject>, withSearchTerm searchTerm: String)
    func onImageRequestFinished(for movieObject: MovieObject)
}

class MovieRequestHandler {
    static let shared = MovieRequestHandler()
    
    private var searchTerm = ""
    static func createSearchInstance(forTerm searchTerm: String) -> MovieRequestHandler {
        let searchInstance = MovieRequestHandler()
        searchInstance.searchTerm = searchTerm
        return searchInstance
    }
    
    private let tmdbApiKey = "4bd981f7a4be201da0f68bb309a6bc59"
    
    private let movieRequestURL = "https://api.themoviedb.org/3/movie/popular"
    private let searchRequestURL = "https://api.themoviedb.org/3/search/movie"
    private let imageRequestURL = "https://image.tmdb.org/t/p/w500"
    private let genreRequestURL = "https://api.themoviedb.org/3/genre/list"
    
    var currentPage = 0
    var isRequesting = false
    
    func requestMovies(listener: MovieRequestListener) {
        if self.isRequesting {
            return
        }
        self.isRequesting = true
        
        self.currentPage += 1
        
        let url: URL?
        if self.searchTerm.isEmpty {
            let parameters = [
                "page": String(self.currentPage)
            ]
            url = self.buildGETURL(from: self.movieRequestURL, withParameters: parameters)
        } else {
            let parameters = [
                "page": String(self.currentPage),
                "query": searchTerm.replacingOccurrences(of: " ", with: "+").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            ]
            url = self.buildGETURL(from: self.searchRequestURL, withParameters: parameters)
        }
        
        if url != nil {
            URLSession.shared.dataTask(with: url!) { data, resposnse, error in
                self.isRequesting = false
                if error != nil {
                    let alert = UIAlertController(title: "Network error",
                                                  message: "An error occoured while fetching movies data. Please check your network status and try again.",
                                                  preferredStyle: .alert)
                    DispatchQueue.main.async {
                        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                            alert.show(rootVC, sender: self)
                        }
                    }
                    print(error!.localizedDescription)
                }
                if let data = data {
                    let movies = MovieParser.parseAll(from: data)
                    self.requestImages(for: movies, listener: listener)
                    
                    if self.searchTerm.isEmpty {
                        listener.onMoviesRequestFinished(movies)
                    } else {
                        listener.onMoviesRequestFinished(movies, withSearchTerm: self.searchTerm)
                    }
                }
            }.resume()
        }
    }
    
    func requestImages(for movies: Array<MovieObject>, listener: MovieRequestListener) {
        for movieObject in movies {
            if movieObject.posterPath == nil {
                continue
            }
            if let url = URL(string: "\(self.imageRequestURL)/\(movieObject.posterPath!)") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        movieObject.poster = data
                        listener.onImageRequestFinished(for: movieObject)
                    }
                }.resume()
            }
        }
    }
    
    func requestGenres() {
        if let url = self.buildGETURL(from: self.genreRequestURL) {
            URLSession.shared.dataTask(with: url) { data, resposnse, error in
                if let data = data {
                    for genre in GenreParser.parseAll(from: data) {
                        GenreCRUD.add(from: genre)
                    }
                }
            }.resume()
        }
    }
    
    func buildGETURL(from baseURL: String, withParameters parameters: Dictionary<String, String> = [:]) -> URL? {
        var stringURL = "\(baseURL)?api_key=\(self.tmdbApiKey)"
        for parameter in parameters {
            stringURL.append("&\(parameter.key)=\(parameter.value)")
        }
        return URL(string: stringURL)
    }
}
