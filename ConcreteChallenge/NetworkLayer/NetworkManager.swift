//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation

public struct NetworkManager: AnyNetworkManager {
    var task: NetworkSessionDataTask?
    var session: NetworkSession

    public init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    public mutating func request<ServiceType: NetworkService, ResponseType: Decodable>(
        _ endpoint: ServiceType,
        _ completion: @escaping (Result<ResponseType, Error>) -> Void) {

        guard let url = buildURL(for: endpoint) else {
            return completion(.failure(NetworkError.invalidURL))
        }

        let request = buildRequest(for: endpoint, url: url)

        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                return completion(.failure(NetworkError.requestError(error)))
            }

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.emptyResponse))
            }

            guard let data = data else {
                return completion(.failure(NetworkError.emptyData))
            }

            completion(Self.handleResponse(response, data: data))
        })

        task?.resume()
    }

    public mutating func cancel() {
        task?.cancel()
    }

    func buildURL<ServiceType: NetworkService>(for endpoint: ServiceType) -> URL? {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        if case let .requestURLParameters(parameters) = endpoint.task {
            urlComponents.queryItems = parameters.map({ key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            })
        }

        return urlComponents.url
    }

    func buildRequest<ServiceType: NetworkService>(for endpoint: ServiceType, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.headers {
            headers.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        if case let .requestBodyParameters(parameters) = endpoint.task,
            let encodedParameters = try? parameters.encoded() {
            request.httpBody = encodedParameters
        }

        return request
    }

    static func handleResponse<ResponseType: Decodable>(_ response: HTTPURLResponse,
                                                        data: Data) -> Result<ResponseType, Error> {
        switch response.statusCode {
        case 200...299:
            do {
                let result: ResponseType = try data.decoded()
                return .success(result)
            } catch {
                return .failure(NetworkError.decodeError(error))
            }
        case 300...399:
            debugPrint(String(data: data, encoding: .utf8)!)
            return .failure(NetworkError.redirectingError(nil))
        case 400...499:
            debugPrint(String(data: data, encoding: .utf8)!)
            return .failure(NetworkError.clientError(nil))
        case 500...599:
            debugPrint(String(data: data, encoding: .utf8)!)
            return .failure(NetworkError.serverError(nil))
        default:
            debugPrint(String(data: data, encoding: .utf8)!)
            return .failure(NetworkError.unknown)
        }
    }
}
