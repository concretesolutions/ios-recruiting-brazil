//
//  TMDBService.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

class TMDBService {
    
    private let session = URLSession.shared
    
    init (){}
    
    func getPopularMovies(page:Int, answer: @escaping(Result<[Movie]>) -> Void) {
        let endpoint = TMDB.endPoint.popularMovies
        var urlComps = URLComponents(string: endpoint)
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: TMDB.apiKey),
            URLQueryItem(name: "language", value: TMDB.language.english)
        ]
        
        if page >= 1 {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
            answer(.error(
                TMDBServiceError.buildURL("Failed to build url \"\(TMDB.endPoint.popularMovies)\" with parameters: \(queryItems)")
                ))
            return
        }
        
        let _ = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                answer(.error(
                    TMDBServiceError.unwrapData("Could not get data from request")
                    ))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let moviesResponse = try jsonDecoder.decode(MoviesResponse.self, from: data)
                let results = moviesResponse.results
                answer(.success(results))
            } catch let jsonDecoderError as NSError {
                answer(.error(
                    TMDBServiceError.jsonParse("Failed to parse data as MoviesResponse)", jsonDecoderError)
                    ))
            }
            
        }.resume()
    }
    
    func searchMoviesContaining(_ query:String, page:Int, answer: @escaping(Result<[Movie]>) -> Void) {
        let endpoint = TMDB.endPoint.searchMovies
        var urlComps = URLComponents(string: endpoint)
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: TMDB.apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "language", value: TMDB.language.english)
        ]
        
        if page >= 1 {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
            answer(.error(
                TMDBServiceError.buildURL("Failed to build url \"\(TMDB.endPoint.searchMovies)\" with parameters: \(queryItems)")
                ))
            return
        }
        
        let _ = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                answer(.error(
                    TMDBServiceError.unwrapData("Could not get data from request")
                    ))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let moviesResponse = try jsonDecoder.decode(MoviesResponse.self, from: data)
                let results = moviesResponse.results
                answer(.success(results))
            } catch let jsonDecoderError as NSError {
                answer(.error(
                    TMDBServiceError.jsonParse("Failed to parse data as MoviesResponse)", jsonDecoderError)
                    ))
            }
            
        }.resume()
    }
    
    func getGenres(answer: @escaping(Result<[Genre]>) -> Void) {
        let endpoint = TMDB.endPoint.genresList
        var urlComps = URLComponents(string: endpoint)
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: TMDB.apiKey),
            URLQueryItem(name: "language", value: TMDB.language.english)
        ]
        
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
            answer(.error(
                TMDBServiceError.buildURL("Failed to build url \"\(TMDB.endPoint.searchMovies)\" with parameters: \(queryItems)")
                ))
            return
        }
        
        let _ = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                answer(.error(
                    TMDBServiceError.unwrapData("Could not get data from request")
                    ))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let genresResponse = try jsonDecoder.decode(GenresResponse.self, from: data)
                let results = genresResponse.genres
                answer(.success(results))
            } catch let jsonDecoderError as NSError {
                answer(.error(
                    TMDBServiceError.jsonParse("Failed to parse data as GenresResponse)", jsonDecoderError)
                    ))
            }
            
        }.resume()
    }
    
}
