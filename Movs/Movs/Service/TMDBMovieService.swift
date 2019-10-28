//
//  TMDBMovieService.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

struct APIConfiguration {
    
}

class TMDBMovieService: MovieServiceProtocol {
    private init() {}
    static private(set) var shared: MovieServiceProtocol = TMDBMovieService()
    
    private(set) var popularMovies: [Movie] = []
    private(set) var favoriteMovies: [Movie] = []
    
    private func urlRequestFor(path: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3\(path)"
        let apiKeyItem = URLQueryItem(name: "api_key", value: "fc6b049905f30ded698536f6721cc0b1")
        urlComponents.queryItems = [apiKeyItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        let request = URLRequest(url: url)
        return request
    }
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    private lazy var favoritsDocumentUrl: URL = {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url.appendingPathComponent("favorites.json")
        } else {
            fatalError("Could not retrieve documents directory")
            // TODO: deal with this error
        }
    }()
    
    func fetchPopularMovies(completion: @escaping MoviesListCompletionBlock) {
        let request = self.urlRequestFor(path: "/movie/popular")
        
        let task = self.urlSession.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let _ = responseError {
                    completion(.genericError, [])
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(APIResponse.self, from: jsonData)
                        self.popularMovies = response.results
                        completion(nil, self.popularMovies)
                    } catch {
                        completion(.genericError, [])
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchFavoriteMovies(completion: @escaping MoviesListCompletionBlock) {
        let fileExists = FileManager.default.fileExists(atPath: self.favoritsDocumentUrl.path)
        if !fileExists {
            completion(nil, self.favoriteMovies)
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: self.favoritsDocumentUrl)
            let movies = try decoder.decode([Movie].self, from: data)
            for movie in movies {
                movie.isFavorite = true
            }
            self.favoriteMovies = movies
            completion(nil, self.favoriteMovies)
        } catch {
            completion(.genericError, [])
        }
    }
    
    func toggleFavorite(for movie: Movie, completion: SuccessOrErrorCompletionBlock?) {
        // TODO: save favorite status
        if (movie.isFavorite) {
            self.favoriteMovies.removeAll { (curMovie) -> Bool in
                curMovie.id == movie.id
            }
        } else {
            self.favoriteMovies.append(movie)
        }
        
        movie.isFavorite = !movie.isFavorite
        NotificationCenter.default.post(name: .didUpdateFavoritesList, object: self)
        
        self.saveFavoritesToDisk(completion: completion)
        completion?(true, nil)
    }
    
    private func saveFavoritesToDisk(completion: SuccessOrErrorCompletionBlock?) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.favoriteMovies)
            try data.write(to: self.favoritsDocumentUrl)
            completion?(true, nil)
            
        } catch {
            completion?(false, .genericError)
        }
    }
}
