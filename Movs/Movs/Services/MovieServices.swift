//
//  MovieServices.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias MovieServicesCallback = ((Result<MoviesList>) -> Void)

class MovieServices: ServicesBase {
  
  public static let shared = MovieServices()
  
  fileprivate override init() {}
  
  internal func fetchMovies(_ language: String = Locale.current.languageCode ?? "en-US", page: Int = 1, handler: @escaping MovieServicesCallback) {
    let url = self.makeURL(.grid)
    
    // Append the language at 'params' to request
    defaultParams["language"] = language
    
    // Append the pagination at 'params' to request
    defaultParams["page"] = page
    
    Alamofire.request(url, method: .get, parameters: defaultParams).responseDecodableObject(decoder: decoder) { (response: DataResponse<MoviesList>) in
      
      switch response.result {
      case .success(let moviesList):
        handler(.success(moviesList))
        
      case .failure(let error):
        let errorMessage = self.parseError(error)
        handler(.error(errorMessage))
      }
    }
  }
  
}
