//
//  MovieService.swift
//  movies
//
//  Created by Jacqueline Alves on 03/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

public enum MovieError: Error {
    case apiError
    case invalidURL
    case invalidResponse
    case noData
    case serializationError
}

class MovieService {
    private static let apiKey = "094fd8f84048425f068f6965ca8bb6af"
    private static let baseAPIURL = "https://api.themoviedb.org/3"
    public static var genres: [Int: String] = [:]
    
    private static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return jsonDecoder
    }()
    
    /// Fetch movies from API using given params
    /// - Parameters:
    ///   - params: Request params
    ///   - completion: Results handler
    static public func fecthMovies(params: [String: String]? = nil, completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/popular") else { // URL to request from
            completion(.failure(MovieError.invalidURL))
            return
        }
        
        MovieService.request(urlComponents: urlComponents, params: params) { result in // Request data from url with params
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let data):
                do {
                    let movieResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data) // Try to decode response
                    
                    DispatchQueue.main.async {
                        completion(.success(movieResponse))
                    }
                } catch {
                    completion(.failure(MovieError.serializationError))
                }
            }
        }
    }
    
    /// Fetch genres and their ids from API
    static public func fetchGenres() {
        guard let urlComponents = URLComponents(string: "\(baseAPIURL)/genre/movie/list") else { return } // URL to request from

        MovieService.request(urlComponents: urlComponents) { result in // Request data from url
            switch result {
            case .failure(let error):
                print(error)
                return
                
            case .success(let data):
                do {
                    let genresResponse = try self.jsonDecoder.decode(GenresResponse.self, from: data) // Try to decode response
                    
                    DispatchQueue.main.async {
                        guard let genres = genresResponse.genres else { return } // Get list of genres from response
                        let genresDict = genres.reduce([Int: String](), { (dict, genre) -> [Int: String] in // Convert the list of genres to a dictionary
                            var dict = dict
                            dict[genre.id] = genre.name
                            
                            return dict
                        })
                        
                        self.genres = genresDict // Set the dictionaty to the genres of class
                    }
                } catch {
                    return
                }
            }
        }
    }
    
    /// Search a movie from API according to the given query text
    /// - Parameters:
    ///   - query: Text to be searching for on API
    ///   - params: Request params
    ///   - completion: Results handler
    static public func searchMovie(query: String, params: [String: String]? = nil, completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: "\(baseAPIURL)/search/movie") else { // URL to request from
            completion(.failure(MovieError.invalidURL))
            return
        }
        
        var params: [String: String] = params ?? [:] // Initialize params dictionaty as empty if nil
        params["query"] = query
        
        MovieService.request(urlComponents: urlComponents, params: params) { result in // Request data from url with params
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let data):
                do {
                    let movieResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data) // Try to decode response
                    
                    DispatchQueue.main.async {
                        completion(.success(movieResponse))
                    }
                } catch {
                    completion(.failure(MovieError.serializationError))
                }
            }
        }
    }
    
    /// Request an URL from API
    /// - Parameters:
    ///   - urlComponents: Base URL with endpoint to request
    ///   - params: Request params
    ///   - completion: Results handler
    static private func request(urlComponents: URLComponents, params: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        var urlComponents = urlComponents
        var queryItems = [ URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { // Check it the final url is valid
            completion(.failure(MovieError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { // Check if request returned an error
                completion(.failure(MovieError.apiError))
                return
            }
            
            // Check if the http response status code is >= 200 and <= 300
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(MovieError.invalidResponse))
                return
            }
            
            guard let data = data else { // Check if returned any data
                completion(.failure(MovieError.noData))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
}
