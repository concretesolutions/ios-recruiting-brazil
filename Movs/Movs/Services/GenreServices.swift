//
//  GenreServices.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias GenreServicesCallback = ((Result<[Genres]>) -> Void)

class GenreServices: ServicesBase {
  
  public static let shared = GenreServices()
  
  fileprivate override init() {}
  
  internal func fetchGenres(_ language: String = Locale.current.languageCode ?? "en-US", handler: @escaping GenreServicesCallback) {
    let url = self.makeURL(.genres)

    // Append the language at 'params' to request
    defaultParams["language"] = language

    Alamofire.request(url, method: .get, parameters: defaultParams).responseDecodableObject(keyPath: "genres", decoder: decoder) { (response: DataResponse<[Genres]>) in
      
      switch response.result {
      case .success(let genres):
        handler(.success(genres))
        
      case .failure(let error):
        let errorMessage = self.parseError(error)
        handler(.error(errorMessage))
      }
    }
  }
  
}
