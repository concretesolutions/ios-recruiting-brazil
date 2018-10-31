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
  
  public func fetchPopularMovies(completion: @escaping (Result<[Movie]>) -> Void) {
    Alamofire.request(MoviesAPI.popularMoviesURL).responseJSON { (response) in
      switch response.result {
      case .success:
        if let value = response.result.value {
          let jsonResponse = JSON(value)
          if let results = jsonResponse["results"].array {
            completion(.success(MovieParser.convertJSONResultsToMovies(results)))
            break
          }
        }

        fallthrough
        
      case .failure:
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
