//
//  APIClient.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 24/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import RxSwift

/**
 All necessary url paths for resquests in this app.
 */
enum APICallMethods {
    
    case getConfigurations
    case getPopularMovies(page: Int)
    case getSpecificMovie(movieId: String)
    case getPoster(posterPath: String)
    case getGenres

}

extension APICallMethods {
    
    var apiKey: String { return APIClient.apiKey()}
    
//    var parameters: [String : Any]? {
//        return nil
//    }
    
    var path: String {
        switch self {
        case .getConfigurations:
            return "/3/configuration"
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getSpecificMovie(let movieId):
            return "/3/movie/\(movieId)"
        case .getPoster(let posterPath):
            return "/t/p/w500\(posterPath)"
        case .getGenres:
            return "/3/genre/movie/list"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getConfigurations:
            return [URLQueryItem(name: "api_key", value: apiKey)]
        case .getPoster:
            return []
        case .getPopularMovies(let page):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: apiKey)]
        default:
            return [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: apiKey)]

        }
    }

}

enum Host: String {
    case TMDB_API = "api.themoviedb.org"
    case TMDB_IMAGE = "image.tmdb.org"
}


class APIClient {

    //MARK: - Properties
    static var baseURL: URL { return URL(string: "https://api.themoviedb.org/3")!}
    static var apiKey = { return "6ebf41d1cc47e9dba214a246b25d7a1f" }
    
    //static private let apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWJmNDFkMWNjNDdlOWRiYTIxNGEyNDZiMjVkN2ExZiIsInN1YiI6IjVkMzYzYjMxMjVjZDg1MDAxNzliY2ZkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S5UUmfxHH0E5Y4KQc4j3X3PKMZO2blshaGgik8kJh2M"
    
    //MARK: - Functions
    
    /**
     Fetches data from an especific request made by an URL and try to convert it to a T type.
     
     - Parameter host: Component relative to host from an URL.
     - Parameter url: A made URL from the enumerator APICallMethods.
     - Parameter type: A class type that inherits Entity.
     
     - Returns: An observable of T type containing an error or desired result from request.
     */
    static func fetchData<T: Entity>(host: Host, url: APICallMethods, type: T.Type) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = host.rawValue
            urlComponents.path = url.path
            urlComponents.queryItems = url.queryItems
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlComponents.url!, completionHandler: { (data, response, error) -> Void in

                if let err = error {
                    observer.onError(err)
                } else {
                    let decoder = JSONDecoder()
                    guard let info = try? decoder.decode(T.self, from: data!)
                        else {
                            return
                    }
                    
                    observer.onNext(info)
                    observer.onCompleted()
                }
            })
            dataTask.resume()
            
            return Disposables.create(with: {
                
            })
        }
    }
    
    /**
     Fetches an image from an especific request made by an URL.
     
     - Parameter host: Component relative to host from an URL.
     - Parameter url: A made URL from the enumerator APICallMethods.
     
     - Returns: An observable of PosterEntity type containing an error or desired result from request.
     */
    static func fetchImage(host: Host, url: APICallMethods) -> Observable<PosterEntity> {
        return Observable<PosterEntity>.create { observer -> Disposable in
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = host.rawValue
            urlComponents.path = url.path
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlComponents.url!, completionHandler: { (data, response, error) -> Void in
                
                if let err = error {
                    observer.onError(err)
                } else {
                    if let image = UIImage(data: data!) {
                        
                        let poster = PosterEntity(poster: image)
                        observer.onNext(poster)
                    }
                    observer.onCompleted()
                }
            })
            dataTask.resume()
            
            return Disposables.create(with: {
                
            })
        }
    }
}
