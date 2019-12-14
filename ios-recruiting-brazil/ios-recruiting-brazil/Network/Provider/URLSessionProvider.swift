//
//  URLSessionProvider.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
final class URLSessionProvider: Provider {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void) {

        let request = URLRequest(service: service)

        let task = self.session.dataTask(with: request) { (result) in
            self.handleResult(result: result, completion: completion)
        }

        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }

    private func handleResult<T: Decodable>(
        result: Result<(URLResponse, Data), Error>, completion: (Result<T, Error>) -> Void) {

        switch result {
        case .failure(let error):
            print("\n\n\nerror\(error)\n\n\n")
            completion(.failure(error))
        case .success(let response, let data):
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.noJSONData))
            }
            print("RESPONSE: \(httpResponse)")
            if let dataString = String(bytes: data, encoding: .utf8) {
                print("DATA: \(dataString)")
            }
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()

                if let newdata = data as? T {
                    completion(.success(newdata))
                    return
                }
                do {
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    print("ERROR DECODE: \(error)")
                    completion(.failure(NetworkError.unknown))
                }

            default:
                completion(.failure(NetworkError.unknown))
            }
        }

    }
}
