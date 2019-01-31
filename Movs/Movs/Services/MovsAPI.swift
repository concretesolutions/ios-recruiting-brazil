//
//  MovsAPI.swift
//  Movs
//
//  Created by Brendoon Ryos on 25/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Moya
import Keys

fileprivate struct MovsAPIConfig {
  private init() {}
  fileprivate static let keys = MovsKeys()
  static let apikey = keys.theMovieDBKey
}

enum MovsAPI {
  case fetchPopularMovies(page: Int)
  case searchForMovie(query: String, page: Int)
  case fetchGenres
  case fetchImage(named: String)
}

extension MovsAPI: TargetType {
  
  var environmentBaseURL: String {
    switch NetworkManager.environment {
    case .staging:
      return "https://api.themoviedb.org/3/"
    case .qa:
      return ""
    case .production:
      return ""
    }
  }
  
  var baseURL: URL {
    switch self {
    case .fetchImage:
      guard let url = URL(string: "https://image.tmdb.org/t/p/w500") else { fatalError("baseURL could not be configured.") }
      return url
    default:
      guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
      return url
    }
  }
  
  var path: String {
    switch self {
    case .fetchPopularMovies:
      return "movie/popular"
    case .fetchGenres:
      return "genre/movie/list"
    case .searchForMovie:
      return "search/movie"
    case .fetchImage(let name):
      return name
    }
  }
  
  var method: Moya.Method {
    switch self {
    default:
      return .get
    }
  }
  
  var task: Task {
    let authParams = ["api_key": MovsAPIConfig.apikey]
    switch self {
    case .fetchPopularMovies(let page):
      let params: [String: Any] = authParams.merging(["page": "\(page)"]) { (_, new) in new }
      return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    case .searchForMovie(let query, let page):
      let params: [String: Any] = authParams.merging(["query": query, "page": "\(page)"]) { (_, new) in new }
      return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    default:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    default:
      return ["Content-type":"application/json"]
    }
  }
}
