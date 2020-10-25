//
//  NetworkEngine.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

final class NetworkEngine<Target: TargetType> {
    private let provider: MoyaProvider<Target>

    // MARK: - Initializers

    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }

    // MARK: - Functions

    func request<T: Codable>(target: Target, completion: @escaping(Result<T, NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    return completion(.success(try JSONDecoder().decode(T.self, from: response.data)))
                } catch {
                    return completion(.failure(NetworkError.invalidJSON))
                }
            case .failure(let error):
                return completion(.failure(NetworkError.taskError(error: error)))
            }
        }
    }

    func requestVoid(target: Target, completion: @escaping(Result<Void, NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case .failure(let error):
                return completion(.failure(NetworkError.taskError(error: error)))
            }
        }
    }
}
