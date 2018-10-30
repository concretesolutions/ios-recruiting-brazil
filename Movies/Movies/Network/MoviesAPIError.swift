//
//  MoviesAPIError.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

enum MoviesAPIError: Error {
  
  case noInternetConnection
  case unknown
  
  var localizedDescription: String {
    switch self {
    case .unknown:
      return "Unknown"
      
    case .noInternetConnection:
      return "No connection"
    }
  }
  
}
