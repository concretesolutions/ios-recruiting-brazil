//
//  TMDBService.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 20/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

class InternetConnectionError: Error {}

class GenreList: Codable {
    let genres: [Genre]?
}

class Genre: Codable {
    let id: Int?
    let name: String?
}

class PagedResponse: Codable {
    let page: Int?
    let total_pages: Int?
    let total_results: Int?
    let results: [MovieResult]?
}

class MovieResult: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let poster_path: String?
    let genres: [Genre]?
}

class TMDBClient {
    
    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "0b41136b59e63cc4df8ff62c70041327"
    let language = "en-US"

    func loadMovies(pageNumber: Int = 1, completion: @escaping (PagedResponse?, Error?) -> ()) {
        let request = "/movie/popular"
        
        guard let requestURL = URL(string: "\(baseURL)\(request)?api_key=\(apiKey)&language=\(language)&page=\(pageNumber)") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: requestURL) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, InternetConnectionError())
                return
            }
            
            let decoder = JSONDecoder()
            let pagedResponse = try? decoder.decode(PagedResponse.self, from: data)
            
            completion(pagedResponse, error)
        }.resume()
    }
    
    func loadMovieDetails(movieId: Int, completion: @escaping (MovieResult?, Error?) -> ()) {
        guard let requestURL = URL(string: "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)&language=\(language)") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: requestURL) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, InternetConnectionError())
                return
            }
            
            let decoder = JSONDecoder()
            let movieResult = try? decoder.decode(MovieResult.self, from: data)
            
            completion(movieResult, error)
            }.resume()
    }
    
    func loadGenres(completion: @escaping ([Int: String]?, Error?) -> ()) {
        let request = "/genre/movie/list"
        guard let requestURL = URL(string: "\(baseURL)\(request)?api_key=\(apiKey)&language=\(language)") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: requestURL) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, InternetConnectionError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let genreList = try decoder.decode(GenreList.self, from: data).genres ?? []
                var genreDict: [Int: String] = [:]
                
                for genre in genreList {
                    if let genreId = genre.id, let genreName = genre.name {
                        genreDict[genreId] = genreName
                    }
                }
                
                completion(genreDict, error)
            } catch {
                completion(nil, InternetConnectionError())
                return
            }
            
        }.resume()
    }
}
