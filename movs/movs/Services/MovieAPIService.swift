//
//  MovieAPIService.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation
import UIKit

class MovieAPIService {

    // API properties
    private static let keyAPI = "ba993d6b1312f03c80a322c3e00fab4d"
    private static let baseStringURL = "https://api.themoviedb.org/3"
    private static let baseImageStringURL = "http://image.tmdb.org/t/p/"
    private static let imageSize = "w500"
    
    /// Fetch movies genres
    /// - Parameters:
    ///   - completion: The completion handler to call when the load request is complete.
    ///                 Return GenresDTO on success and and Error on failure
    class func fetchGenres(completion: @escaping (Result<GenresDTO, Error>) -> Void) {
        let stringURL = "\(baseStringURL)/genre/movie/list?api_key=\(keyAPI)"
        let url = URL(string: stringURL)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let genres = try? JSONDecoder().decode(GenresDTO.self, from: data) {
                completion(.success(genres))
                return
            }
        }.resume()
    }
    
    /// Fetch popular movies from page
    /// - Parameters:
    ///   - completion: The completion handler to call when the load request is complete.
    ///                 Return GenresDTO on success and and Error on failure
    class func fetchPopularMovies(fromPage page: Int = 1,
                                  completion: @escaping (Result<MoviesRequestDTO, Error>) -> Void) {
        let stringURL = "\(baseStringURL)/movie/popular?api_key=\(keyAPI)&page=\(page)"
        let url = URL(string: stringURL)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let moviesRequest = try? JSONDecoder().decode(MoviesRequestDTO.self, from: data) {
                completion(.success(moviesRequest))
                return
            }
        }.resume()
    }

    /// Fetch movie poster with URL
    /// - Parameters:
    ///   - completion: The completion handler to call when the load request is complete.
    ///                 Return GenresDTO on success and and Error on failure
    class func fetchMoviePoster(withURL imageURL: String,
                                completion: @escaping (Result<UIImage, Error>) -> Void) {
        let stringURL = "\(baseImageStringURL)/\(imageSize)/\(imageURL)?api_key=\(keyAPI)"
        let url = URL(string: stringURL)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let poster = UIImage(data: data) {
                completion(.success(poster))
                return
            }
        }.resume()
    }
}
