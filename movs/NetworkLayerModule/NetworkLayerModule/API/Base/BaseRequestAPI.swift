//
//  BaseRequestAPI.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

///Temporary Global Cache Memory.
var cacheGlobal: [String: Data] = [:]

open class BaseRequestAPI {
    
    let urlSession =  URLSession.shared
    var dataTask: URLSessionDataTask?
    
    public init() {}
    
    public func stop() {
        dataTask?.cancel()
    }
    
    @discardableResult
    public init<Model: Decodable>(api: MtdbAPI, completion: @escaping (Result<Model, MtdbAPIError>) -> Void) {
        self.requestJson(api: api, completion: completion)
    }
    
    @discardableResult
    public init(api: MtdbAPI, completion: @escaping (Result<Data, MtdbAPIError>) -> Void) {
        
        let hasCache = cacheGlobal.contains(where: { $0.key == api.absoluteURL.absoluteString })
        if  hasCache {
            if let dataInCache = cacheGlobal[api.absoluteURL.absoluteString] {
                completion(.success(dataInCache))
                return
            }
        }
        
        self.requestData(api: api, completion: completion)
    }
    
    private func buildUrlRequest(api: MtdbAPI) -> URLRequest? {
        var urlComponent = URLComponents(string: api.absoluteURL.absoluteString)
        urlComponent?.queryItems = [
            URLQueryItem(name: "api_key", value: api.token),
            URLQueryItem(name: "language", value: api.language)
        ]
        
        var urlString = api.absoluteURL.absoluteString
        urlString += "?api_key=" + api.token
        urlString += "&language=" + api.language
        
        guard let url = URL(string: urlString) else {            
            return nil
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: api.cachePolicy, timeoutInterval: api.timeOut)
        urlRequest.httpMethod = api.method.rawValue
        return urlRequest
    }
    
    private func requestData(api: MtdbAPI, completion: @escaping (Result<Data, MtdbAPIError>) -> Void) {
        guard let urlRequest = buildUrlRequest(api: api) else {
            completion(.failure(.baseUrlInvalid))
            return
        }
        
        self.dataTask = self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
            if let data = data {
                cacheGlobal[api.absoluteURL.absoluteString] = data
                completion(.success(data))
            } else {
                completion(.failure(.emptyData))
            }
        })
        self.dataTask?.resume()
    }
    
    private func requestJson<Model: Decodable>(api: MtdbAPI, completion: @escaping (Result<Model, MtdbAPIError>) -> Void) {
        guard let urlRequest = buildUrlRequest(api: api) else {
            completion(.failure(.baseUrlInvalid))
            return
        }
        
        self.dataTask = self.urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let httpResponse = urlResponse as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
            }
            if let error = error {
                completion(.failure(MtdbAPIError.unexpected(error)))
            }
            
            do {
                if let data = data {
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(object))
                } else {
                    completion(.failure(MtdbAPIError.emptyData))
                }
                
            } catch {
                
                do {
                    guard let data = data else {
                        completion(.failure(MtdbAPIError.emptyData))
                        return
                    }
                    _ = try JSONDecoder().decode(InvalidAccessModel.self, from: data)
                    completion(.failure(MtdbAPIError.invalidToken))
                    
                } catch {
                    
                }
                completion(.failure(MtdbAPIError.jsonDecoded))
            }
            
        }
        dataTask?.resume()
    }
}
