//
//  APIProvider.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

final class APIProvider<T: Decodable> {

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<ResultType: Decodable>(_ endPoint: RouterService, completion: @escaping (Result<ResultType, NetworkError>) -> Void) {
        let request = URLRequest(endPoint: endPoint)
        let task = session.dataTask(with: request) { result in
            self.handleResult(result: result, completion: completion)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
        
    private func handleResult<T: Decodable>(result: Result<(URLResponse, Data), Error>,
                                            completion: (Result<T, NetworkError>) -> Void) {
        switch result {
        case .failure(let error):
            completion(.failure(NetworkError.connectionError(error)))
        case .success(let response, let data):
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noResponseData))
                return
            }
            
            //If T is Data type
            if let dataDecodable = data as? T {
                completion(.success(dataDecodable))
            }
            
            guard let dataString = String(bytes: data, encoding: .utf8) else { return }
            
            switch httpResponse.statusCode {
                
            case 200...299:
                do {
                    let model = try data.decode(type: T.self)
                    completion(.success(model))
                } catch {
                    completion(.failure(NetworkError.decodeError(error)))
                }

            case 400...499:
                completion(.failure(NetworkError.clientError(statusCode: httpResponse.statusCode, dataResponse: dataString)))
            case 500...599:
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode, dataResponse: dataString)))
            default:
                completion(.failure(NetworkError.unknown))
            }
        }
    }
}
