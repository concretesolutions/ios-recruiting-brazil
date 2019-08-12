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
    func onRequestFromScrollFinished(_ fetchedMovies: Array<MovieObject>)
    func onImageRequestFinished(for movieObject: MovieObject)
}

class MovieRequestHandler {
    static let shared = MovieRequestHandler()
    
    private let tmdbApiKey = "4bd981f7a4be201da0f68bb309a6bc59"
    
    private let movieRequestURL = "https://api.themoviedb.org/3/movie/popular"
    private let imageRequestURL = "https://image.tmdb.org/t/p/w500"
    private let genreRequestURL = "https://api.themoviedb.org/3/genre/list"
    
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
                self.isRequestingFromScroll = false
                if let data = data {
                    let movies = MovieParser.parseAll(from: data)
                    listener.onRequestFromScrollFinished(movies)
                    self.requestImages(for: movies, listener: listener)
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
