//
//  NetworkClient.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Alamofire
import SwiftyJSON

class NetworkClient {
  
  static let shared: NetworkClient = NetworkClient()
  
  var currentPage = 0
  
  var totalPages = 0
  
  public func fetchPopularMovies(completion: @escaping (Result<[Movie]>) -> Void) {
    currentPage += 1
    let parameters: Parameters = ["sort_by": "popularity.desc", "api_key": MoviesAPI.apiKey, "page": "\(currentPage)"]

    if currentPage != 1 && currentPage > totalPages {
      return
    }
    
    Alamofire.request(MoviesAPI.popularMoviesURL, parameters: parameters).responseJSON { (response) in
      switch response.result {
      case .success:
        if let value = response.result.value {
          let jsonResponse = JSON(value)
          if let results = jsonResponse["results"].array {
            
            if self.currentPage == 1 {
              if let totalPages = jsonResponse["total_pages"].int {
                  self.totalPages = totalPages
              }
            }
            
            completion(.success(MovieParser.convertJSONResultsToMovies(results)))
            break
          }
        }

        fallthrough
        
      case .failure:
        self.currentPage -= 1
        if response.response?.statusCode != nil {
          completion(.failure(MoviesAPIError.noInternetConnection))
        } else {
          completion(.failure(MoviesAPIError.unknown))
        }
      }
    }
  }
  
  public func getImageDownloadURL(fromPath path: String) -> URL {
    guard let url = URL(string: "\(MoviesAPI.imagesURL)/\(path)") else {
      fatalError("Invalid path")
    }
    
    return url
  }
}
