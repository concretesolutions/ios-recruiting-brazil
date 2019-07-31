//
//  TheMovieServiceAPI.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import RxSwift

final class TheMovieServiceAPI {
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: NetworkConstants.baseURL)!
    private let apiKey = NetworkConstants.apiKey
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    public enum APIServiceError: String, Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    
    /// Método base para requisições na API
    ///
    /// - Parameters:
    ///   - url: url base
    ///   - items: parametros inline
    /// - Returns: Fluxo contendo o resultado da busca
    private func fetchResources<T: Decodable>(url: URL, items: [URLQueryItem] = []) -> Observable<Result<T, APIServiceError>> {
        return Observable<Result<T, APIServiceError>>.create { [weak self] observer -> Disposable in
            
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                observer.onNext(.failure(APIServiceError.invalidEndpoint))
                return Disposables.create()
            }
            
            guard let apiKey = self?.apiKey else {
                observer.onNext(.failure(APIServiceError.apiError))
                return Disposables.create()
            }
            
            var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
            queryItems.append(contentsOf: items)
            
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else {
                observer.onError(APIServiceError.invalidEndpoint)
                return Disposables.create()
            }
            
            self?.urlSession.dataTask(with: url) { data, response, error in
                
                if let data = data, let response = response {
                    
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        observer.onError(APIServiceError.invalidResponse)
                        return
                    }
                    
                    do {
                        let values = try self?.jsonDecoder.decode(T.self, from: data)
                        observer.onNext(.success(values!))
                    } catch {
                        observer.onNext(.failure(APIServiceError.decodeError))
                        return
                    }
                }
                
                if error != nil {
                    observer.onNext(.failure(APIServiceError.apiError))
                }
                
            }.resume()
            
            return Disposables.create()
        }
    }
    
    
    /// Busca filmes de uma página na API
    ///
    /// - Parameter page: Página a ser buscada
    /// - Returns: fluxo com o resultado da busca
    func fetchMovies(page: Int) -> Observable<Result<MoviesResponse, APIServiceError>> {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent("popular")
        
        return fetchResources(url: movieURL, items: [URLQueryItem(name: "page", value: String(page))])
    }
    
    
    /// Busca todos os generos da api
    ///
    /// - Returns: fluxo com o resultado da busca
    func fetchGenres() -> Observable<Result<GenresResponse, APIServiceError>> {
        let genreURL = baseURL
            .appendingPathComponent("genre")
            .appendingPathComponent("movie")
            .appendingPathComponent("list")
        
        return fetchResources(url: genreURL)
    }
}
