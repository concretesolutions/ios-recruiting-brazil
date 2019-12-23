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
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        
        do {
            let request = try createRequest(from: route)
            
            self.task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success((data, response)))
                }
            })
            
        } catch {
            completion(.failure(error))
        }
        
        self.task?.resume()
        
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func createRequest(from route: EndPoint) throws -> URLRequest {
        let fullUrl = route.baseUrl.appendingPathComponent(route.path)
        
        var request = URLRequest(url: fullUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
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
