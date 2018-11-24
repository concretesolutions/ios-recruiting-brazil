//
//  TMDBManager.swift
//  Movs
//
//  Created by Julio Brazil on 21/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import Foundation

enum responseType<T> {
    case result(_ value: T)
    case empty(_ query: String)
    case error(description: String?)
}

class TMDBManager {
    public static let shared = TMDBManager()
    public static let imageEndpoint = "https://image.tmdb.org/t/p/w500"
    public static let backdropEndpoint = "https://image.tmdb.org/t/p/w780"
    private let endpoit: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "api_key=099fc4c8b2f724721fa9c5a0f9126240"
    
    private let popularMoviesRoute = "/movie/popular"
    private let searchMoviesRoute = "/search/movie"
    
    var genres = [Genre]()
    
    var currentPage = 1
    var nextPage: Int {
        get {
            return self.currentPage + 1
        }
    }
    
    var lastUsedURL = ""
    
    private init() {
        self.fetchGenres { [weak self](response) in
            guard let self = self else { return }
            switch response{
            case .result(let genreResponse):
                self.genres = genreResponse.genres
            default:
                //TODO: handle error gracefuly
                return
            }
        }
    }
    
    private func makeRequest<T: Decodable>(toURL url: String, expecting t: T.Type, completion: @escaping (responseType<T>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.error(description: "provided invalid URL"))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completion(.error(description: error?.localizedDescription))
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                completion(.error(description: "received empty response."))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(t, from: responseData)
                completion(.result(data))
            } catch {
                completion(.error(description: "Couldn't deserialize JSON."))
            }
        })
        
        task.resume()
    }
    
    public func fetchGenres(completion: @escaping (responseType<TMDBGenresResponse>) -> Void) {
        self.makeRequest(toURL: "\(self.endpoit)/genre/movie/list?\(self.apiKey)", expecting: TMDBGenresResponse.self, completion: completion)
    }
    
    public func fetchPopularMovies(page: Int = 1, completion: @escaping (responseType<TMDBResponse>) -> Void) {
        self.currentPage = page
        self.lastUsedURL = self.endpoit + self.popularMoviesRoute + "?" + self.apiKey
        self.makeRequest(toURL: self.lastUsedURL + "&page=\(page)", expecting: TMDBResponse.self, completion: completion)
    }
    
    public func fetchMoviesSearching(for query: String, atPage page: Int = 1, completion: @escaping (responseType<TMDBResponse>) -> Void) {
        self.currentPage = page
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        self.lastUsedURL = self.endpoit + self.searchMoviesRoute + "?" + self.apiKey + "&query=" + query
        makeRequest(toURL: self.lastUsedURL + "&page=\(page)", expecting: TMDBResponse.self, completion: completion)
    }
    
    func getNextPage(completion: @escaping (responseType<TMDBResponse>) -> Void) {
        self.currentPage = self.nextPage
        makeRequest(toURL: self.lastUsedURL + "&page=\(self.currentPage)", expecting: TMDBResponse.self, completion: completion)
    }
    
    public func genreNames(forIds ids: [Int]) -> [String] {
        let array: [String] = ids.map { [weak self] (id) -> String in
            guard let self = self else { return "NotFound" }
            
            return self.genres.first(where: { (genre) -> Bool in
                genre.id == id
            })?.name ?? "NotFound"
        }
        
        return array
    }
}
