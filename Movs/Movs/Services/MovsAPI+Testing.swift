//
//  MovsAPI+Testing.swift
//  Movs
//
//  Created by Brendoon Ryos on 25/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Moya

extension MovsAPI {
  var sampleData: Data {
    switch self {
    case .fetchGenres:
      return stubbedResponse("GenresData")
    case .fetchPopularMovies:
      return stubbedResponse("MoviesData")
    default:
      return Data()
    }
  }
  
  func stubbedResponse(_ filename: String, bundle: Bundle = .main) -> Data! {
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
  }
}
