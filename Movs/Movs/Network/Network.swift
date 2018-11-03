//
//  Network.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 31/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class Network {
  static let shared = Network()
  
  private var apiKey = "08b52517e7bb9f9a3a2ab5b6310dcc5e"
  private var language = "pt-BR"
  private var page = 1
  
  private var type = "popular"
  private var genre = ""
  
  
  func requestPopularMovies(completion: @escaping (Result<Page?>) -> ()) {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(type)?api_key=\(apiKey)&language=\(language)&page=\(page)") else {return}
 
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringCacheData
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
      DispatchQueue.main.async {
        if let error = responseError {
          completion(.failure(error))
        } else if let jsonData = responseData {
          let decoder = JSONDecoder()
          do {
            let movies = try decoder.decode(Page.self, from: jsonData)
            completion(.success(movies))
          }catch {
            completion(.failure(error))
            
          }
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func requestPopularMovies(numberOfPage: Int, completion: @escaping (Result<Page?>) -> ()) {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(type)?api_key=\(apiKey)&language=\(language)&page=\(numberOfPage)") else {return}
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringCacheData
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
      DispatchQueue.main.async {
        if let error = responseError {
          completion(.failure(error))
        } else if let jsonData = responseData {
          let decoder = JSONDecoder()
          do {
            let movies = try decoder.decode(Page.self, from: jsonData)
            completion(.success(movies))
          }catch {
            completion(.failure(error))
            
          }
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func requestImage(imageName: String ,completion: @escaping (Result<UIImage?>) -> ()) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageName)") else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
      DispatchQueue.main.async {
        if let error = responseError {
          completion(.failure(error))
        } else if let jsonData = responseData {
          let image = UIImage(data: jsonData)
          completion(.success(image))
          
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func requestMovieById(id: Int, completion: @escaping(Result<Movie?>) -> ()) {
    guard let url = URL(string: "http://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=\(language)") else {return}
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
      DispatchQueue.main.async {
        if let error = responseError {
          completion(.failure(error))
        } else if let jsonData = responseData {
          let decoder = JSONDecoder()
          do {
            let movies = try decoder.decode(Movie.self, from: jsonData)
            completion(.success(movies))
          }catch {
            completion(.failure(error))
            
          }
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func requestGenres(completion: @escaping(Result<ResultGenres?>) -> ()) {
    guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=\(language)") else {return}
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
      DispatchQueue.main.async {
        if let error = responseError {
          completion(.failure(error))
        } else if let jsonData = responseData {
          let decoder = JSONDecoder()
          do {
            let result = try decoder.decode(ResultGenres.self, from: jsonData)
            completion(.success(result))
          }catch {
            completion(.failure(error))
          }
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }

}
