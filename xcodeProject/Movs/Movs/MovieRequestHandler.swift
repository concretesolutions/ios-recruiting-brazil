//
//  MovieRequestHandler.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

enum RequestModifier {
    case SEARCH
    case FILTER
    case FILTER_SEARCH
}

protocol MovieRequestListener {
    func onRequestFromScrollFinished()
    func onImageRequestFinished(forMovieAt index: Int)
}

class MovieRequestHandler {
    static let shared = MovieRequestHandler()
    
    private let tmdbApiKey = "4bd981f7a4be201da0f68bb309a6bc59"
    private let movieRequestURL = "https://api.themoviedb.org/3/movie/popular"
    private let imageRequestURL = "https://image.tmdb.org/t/p/w500"
    
    var allMovies: Array<Movie> = []
    let favoriteMovies: Array<Movie> = []
    
    var currentPage = 1
    var isRequestingFromScroll = false
    
    //func requestMovies(with requestModifier: RequestModifier? = nil) {
        //let url = self.buildGETURL(from: self.movieRequestURL)
    //}
    
    func requestMoviesFromScroll(listener: MovieRequestListener) {
        if self.isRequestingFromScroll {
            return
        }
        self.isRequestingFromScroll = true
        
        self.currentPage += 1
        let parameters = [
            "page": String(self.currentPage)
        ]
        if let url = self.buildGETURL(from: self.movieRequestURL, withParameters: parameters) {
            URLSession.shared.dataTask(with: url) { data, resposnse, error in
                if let data = data {
                    let movies = MovieParser.parseAll(from: data)
                    self.allMovies.append(contentsOf: movies)
                    self.isRequestingFromScroll = false
                    listener.onRequestFromScrollFinished()
                    self.requestImages(listener: listener)
                }
            }.resume()
        }
    }
    
    func requestImages(listener: MovieRequestListener) {
        for (index, movie) in self.allMovies.enumerated() {
            if movie.attrCover != nil || movie.attrCoverPath == nil {
                continue
            }
            if let url = URL(string: "\(self.imageRequestURL)/\(movie.attrCoverPath!)") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        movie.attrCover = data
                        listener.onImageRequestFinished(forMovieAt: index)
                    }
                }.resume()
            }
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
