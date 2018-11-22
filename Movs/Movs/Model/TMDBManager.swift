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
  public lazy var shared = TMDBManager()
  private let endpoit: String = "https://api.themoviedb.org/3"
  private let apiKey: String = "api_key=099fc4c8b2f724721fa9c5a0f9126240"
  
  private let popularMoviesRoute = "/movie/popular"
  private let searchMoviesRoute = "/search/movie"
  
  var genres = [Genre]()
  
  private init() {
    self.fetchGenres { [weak self](response) in
      guard let self = self else {return}
      switch response{
      case .result(let genreResponse):
        self.genres = genreResponse.genres
      default:
        //TODO: handle error gracefuly
        return
      }
    }
  }
  
  private func makeRequest<T: Decodable>(toURL urlName: String, expecting t: T.Type, completion: @escaping (responseType<T>) -> Void) {
    guard let url = URL(string: urlName) else {
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
  
  func fetchGenres(completion: @escaping (responseType<TMDBGenresResponse>) -> Void) {
    self.makeRequest(toURL: "\(self.endpoit)/genre/movie/list?\(self.apiKey)", expecting: TMDBGenresResponse.self, completion: completion)
  }
  
  func fetchPopularMovies(completion: @escaping (responseType<CodableMovie>) -> Void) {
    self.makeRequest(toURL: self.endpoit + self.popularMoviesRoute + "?" + self.apiKey, expecting: CodableMovie.self, completion: completion)
  }
  
  func fetchMoviesSearching(for query: String, completion: @escaping (responseType<CodableMovie>) -> Void) {
    makeRequest(toURL: self.endpoit + self.searchMoviesRoute + "?" + self.apiKey + "&query=" + query, expecting: CodableMovie.self, completion: completion)
  }
}
