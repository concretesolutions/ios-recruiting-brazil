//
//  URLSessionProvider.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case noJSONData
    case invalidRequest
    case invalidStatusCode
}

final class URLSessionProvider: Provider {
    private var session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void) {

        guard let request = URLRequest(service: service) else {
            return completion(.failure(NetworkError.invalidRequest))
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let httpResponse = response as? HTTPURLResponse, let validData = data else {
                return completion(.failure(NetworkError.noJSONData))
            }

            self.handleResult(data: validData, response: httpResponse, completion: completion)
        }

        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }

    private func handleResult<T: Decodable>(
        data: Data, response: HTTPURLResponse, completion: (Result<T, Error>) -> Void) {
        if case 200...299 = response.statusCode {
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NetworkError.invalidStatusCode))
        }
    }

    func request(service: Service, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = URLRequest(service: service) else {
            return completion(.failure(NetworkError.invalidRequest))
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let httpResponse = response as? HTTPURLResponse, let validData = data else {
                return completion(.failure(NetworkError.noJSONData))
            }

            if case 200...299 = httpResponse.statusCode {
                completion(.success(validData))
            } else {
                completion(.failure(NetworkError.invalidStatusCode))
            }
        }

        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }

}
