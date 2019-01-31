//
//  NetworkManager.swift
//  Movs
//
//  Created by Brendoon Ryos on 25/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Moya

enum Result<T> {
  case success(T)
  case error(ErrorType)
}

enum APIEnvironment {
  case staging
  case qa
  case production
}

protocol Networkable {
  var provider: MoyaProvider<MovsAPI> { get }
  func fetchMovies(request: Movies.Popular.Request, completion: @escaping (Result<MoviesData>) -> ())
  func fetchGenres(completion: @escaping (Result<GenresData>) -> ())
}

class NetworkManager: Networkable {
  let provider = MoyaProvider<MovsAPI>(manager: DefaultAlamofireManager.sharedManager)
  //, plugins: [NetworkLoggerPlugin(verbose: true)]
  static let environment: APIEnvironment = .staging
  
  func fetchMovies(request: Movies.Popular.Request, completion: @escaping (Result<MoviesData>) -> ()) {
    print("PAGE", request.page)
    provider.request(.fetchPopularMovies(page: request.page)) { result in
      switch result {
      case .success(let response):
        do {
          let moviesData = try JSONDecoder().decode(MoviesData.self, from: response.data)
          completion(Result.success(moviesData))
        } catch {
          completion(Result.error(.server))
          print("data could not be decoded: \(error)")
        }
      case .failure:
        completion(Result.error(.server))
      }
    }
  }
  
  func fetchGenres(completion: @escaping (Result<GenresData>) -> ()) {
    provider.request(.fetchGenres) { result in
      switch result {
      case .success(let response):
        do {
          let genresData = try JSONDecoder().decode(GenresData.self, from: response.data)
          completion(Result.success(genresData))
        } catch {
          completion(Result.error(.server))
        }
      case .failure:
        completion(Result.error(.server))
      }
    }
  }
}
