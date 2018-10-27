//
//  Router.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {

    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)

        request.httpMethod = route.httpMethod.rawValue

        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)

            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                self.addAditionalHeaders(additionalHeaders: additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    private func addAditionalHeaders(additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {return}

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

}
