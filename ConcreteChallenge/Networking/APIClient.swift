//
//  APIClient.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import Sentry

protocol ClientProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

class Client: ClientProtocol {
    private let manager: Alamofire.Session
    private let baseUrl: URL
    private let queue = DispatchQueue(label: "APIClientQueue")
    private let defaultParameters: Parameters

    static let shared = Client()

    init(baseUrl: String, apiKey: String) {
        self.defaultParameters = ["api_key": apiKey, "language": "pt-BR"]
        self.baseUrl = URL(string: baseUrl)!

        let configuration = URLSessionConfiguration.default
        configuration.urlCredentialStorage = nil
        self.manager = Alamofire.Session(configuration: configuration)
    }

    convenience init () {
        self.init(baseUrl: Environment.MovieDBApi.baseUrl, apiKey: Environment.MovieDBApi.apiKey)
    }
    func mergeParameters(dict: Parameters?) -> Parameters {
        guard var newParameters = dict else {
            return self.defaultParameters
        }

        for (key, value) in self.defaultParameters {
            newParameters.updateValue(value, forKey: key)
        }
        return newParameters
    }

    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        let parameters = mergeParameters(dict: endpoint.parameters)
        let url = self.url(path: endpoint.path)

        return Single<Response>.create { observer in
            let request = self.manager.request(
                url,
                method: endpoint.method,
                parameters: parameters
            )
            request
                .validate()
                .responseData(queue: self.queue) { response in
                    let result = response.result.flatMap { (data) -> Result<Response, AFError> in
                        do {
                            let decoded = try endpoint.decode(data)
                            return .success(decoded)
                        } catch {
                            return .failure(
                                AFError.parameterEncoderFailed(
                                    reason: .encoderFailed(error: error)
                                )
                            )
                        }
                    }
                    switch result {
                    case let .success(value): observer(.success(value))
                    case let .failure(error):
                        let scope = Scope()

                        scope.setTag(value: url.absoluteString, key: "api-failure.path")
                        scope.setTag(value: "themoviedb", key: "api-failure.service-name")

                        scope.setExtras([
                            "endpoint": endpoint.asDictionary,
                            "parameters": parameters,
                            "request": request.cURLDescription(),
                            "response": response.description
                        ])

                        let notification = NotificationBannerConfig(
                            title: "Ocorreu um erro",
                            subtitle: "Falha ao comunicar com o servidor."
                        )

                        ErrorReporting.capture(error, including: scope, notifying: notification)

                        observer(.error(error))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func url(path: String) -> URL {
        return self.baseUrl.appendingPathComponent(path)
    }
}
