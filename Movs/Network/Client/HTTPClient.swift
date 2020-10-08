//
//  HTTPClient.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

final class HttpClient: HttpClientProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension HttpClient {

    typealias DecodingCompletionHandler = (Decodable?, APIError?) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completionHandler completion: @escaping (T?, APIError?) -> Void) -> URLSessionDataTask {

        let task = self.session.dataTask(with: request) { data, response, error in

            guard let httpResponse = response as? HTTPURLResponse else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                    completion(nil, .requestCancelled)
                } else {
                    completion(nil, .requestFailed(reason: error?.localizedDescription))
                }
                return
            }
            switch httpResponse.statusCode {
            case 200...399:
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(decodingType, from: data)
                        completion(model, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            default:
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }

    func request<T: Decodable>(_ request: URLRequest, decode: ((T) -> T)?, completion: @escaping (Result<T, APIError>) -> Void) {

        let task = self.decodingTask(with: request, decodingType: T.self) { json, error in

            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let json = json {
                    if let value = decode?(json) {
                        completion(.success(value))
                    } else {
                        completion(.success(json))
                    }
                }
            }
        }
        task.resume()
    }

    func cancelAllRequests() {
        self.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
