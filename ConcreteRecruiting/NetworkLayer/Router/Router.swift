//
//  Router.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation
import NetworkLayer

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    var task: URLSessionTask?
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ route: EndPoint, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let request = try createRequest(from: route)
            
            self.task = self.session.dataTask(with: request) { (result) in
                self.handleResult(result: result, type: T.self, completion: completion)
            }

        } catch {
            completion(.failure(error))
        }
        
        self.task?.resume()
        
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func handleResult<T: Decodable>(result: Result<(Data, URLResponse), Error>, type: T.Type, completion: (Result<T, Error>) -> Void) {
        
        switch result {
            
        case .failure(let error):
            return completion(.failure(error))
            
        case .success(let data, let response):
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.noJson))
            }
            
            switch response.statusCode {
                
            case 200...299:
                do {
                    if type != Data.self {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } else {
                        guard let data = data as? T else { return completion(.failure(NetworkError.parsingError)) }
                        completion(.success(data))
                    }
                } catch {
                    completion(.failure(NetworkError.parsingError))
                }
                
            case 400...499:
                completion(.failure(NetworkError.apiError))
            default:
                completion(.failure(NetworkError.unknown))
                
            }
            
        }
        
    }
    
    private func createRequest(from route: EndPoint) throws -> URLRequest {
        let fullUrl = route.baseUrl.appendingPathComponent(route.path)
        
        var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        if route.baseUrl.relativeString == NetworkManager.baseImageUrl {
            cachePolicy = .returnCacheDataElseLoad
        }
        
        var request = URLRequest(url: fullUrl, cachePolicy: cachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = route.method.rawValue
        
        do {
            
            switch route.task {
            case .requestPlain:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestUrlParameters(let urlParameters):
                try URLParameterEncoder.encode(&request, with: urlParameters)
            default:
                fatalError("Task \(route.task) not yet implemented!")
            }
                
            return request
            
        } catch {
            throw error
        }
        
    }
    
}
