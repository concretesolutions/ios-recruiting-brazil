//
//  MovieAPIService.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation
import UIKit

final class MovieAPIService: DataSource {

    // MARK: - API properties
    private static let keyAPI = "ba993d6b1312f03c80a322c3e00fab4d"
    private static let baseStringURL = "https://api.themoviedb.org/3"
    private static let baseImageStringURL = "http://image.tmdb.org/t/p"
    private static let imageSize = "w500"
    
    // MARK: - Fetches
    class func fetchGenres(completion: @escaping (Result<GenresDTO, Error>) -> Void) {
        let stringURL = "\(baseStringURL)/genre/movie/list?api_key=\(keyAPI)"
        let url = URL(string: stringURL)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            guard let _ = response, let data = data else {
                completion(.failure(error))
                return
            }
            
            if let genres = try? JSONDecoder().decode(GenresDTO.self, from: data) {
                completion(.success(genres))
                return
            } else {
                completion(.failure(error))
            }
        }.resume()
    }
    
    class func fetchPopularMovies(of page: Int = 1,
                                  completion: @escaping (Result<MoviesRequestDTO, Error>) -> Void) {
        let stringURL = "\(baseStringURL)/movie/popular?api_key=\(keyAPI)&page=\(page)"
        let url = URL(string: stringURL)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            guard let _ = response, let data = data else {
                completion(.failure(error))
                return
            }
            
            if let moviesRequest = try? JSONDecoder().decode(MoviesRequestDTO.self, from: data) {
                completion(.success(moviesRequest))
                return
            } else {
                completion(.failure(error))
            }
        }.resume()
    }

    class func fetchMoviePoster(with imageURL: String,
                                completion: @escaping (Result<UIImage, Error>) -> Void) {
        let stringURL = "\(baseImageStringURL)/\(imageSize)/\(imageURL)?api_key=\(keyAPI)"
        let url = URL(string: stringURL)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let poster = UIImage(data: data) {
                completion(.success(poster))
                return
            } else {
                completion(.failure(error))
            }
        }.resume()
    }
    
    class func fetchMovieDetail(with id: Int,
                                completion: @escaping (Result<MovieDetailDTO, Error>) -> Void) {
        let stringURL = "\(baseStringURL)/movie/\(id)?api_key=\(keyAPI)"
        let url = URL(string: stringURL)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let movie = try? JSONDecoder().decode(MovieDetailDTO.self, from: data) {
                completion(.success(movie))
                return
            } else {
                completion(.failure(error))
            }
        }.resume()
    }
}
