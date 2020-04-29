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

func convertToDictionary(data: Data) -> [String: Any]? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        print(error.localizedDescription)
    }
    return nil
}

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
        self.manager = Alamofire.Session(configuration: configuration)
    }
    
    convenience init () {
        self.init(baseUrl: Constants.api.baseUrl, apiKey: Constants.api.apiKey)
    }
    func mergeParameters(dict: Parameters?) -> Parameters {
        guard var newParameters = dict else {
            return self.defaultParameters
        }
        
        for (k, v) in self.defaultParameters {
            newParameters.updateValue(v, forKey: k)
        }
        return newParameters
    }

    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        let parameters = mergeParameters(dict: endpoint.parameters)
        let url = self.url(path: endpoint.path)
        
        return Single<Response>.create { observer in
            let request = self.manager.request(
                url,
                method: httpMethod(from: endpoint.method),
                parameters: parameters
            )
            request
                .validate()
                .responseData(queue: self.queue) { response in
//                    print(url)
//                    print(endpoint)
                    let result = response.result.flatMap { (data) -> Result<Response, AFError> in
                        do {
                            let decoded = try endpoint.decode(data)
                            return .success(decoded)
                        } catch {
                            print(parameters)
                            print(endpoint)
                            print(request)
                            let json = String(decoding: data, as: UTF8.self)
                            print(json)
                            return .failure(AFError.parameterEncoderFailed(reason: .encoderFailed(error: error)))
                        }
                    }
                    switch result {
                    case let .success(val): observer(.success(val))
                    case let .failure(err): observer(.error(err))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func url(path: Path) -> URL {
        return self.baseUrl.appendingPathComponent(path)
    }
}

private func httpMethod(from method: Method) -> Alamofire.HTTPMethod {
    switch method {
    case .get: return .get
    case .post: return .post
    case .put: return .put
    case .patch: return .patch
    case .delete: return .delete
    }
}

