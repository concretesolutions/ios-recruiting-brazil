//
//  ParserProvider+requestAndParse.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// It has a default implementation to the requestAndParse method of ParsableProvider.
extension ParserProvider {
    public typealias ParsableType = ParserType.ParsableType
    
    public func requestAndParse(route: RouteType, completion: @escaping (Result<ParsableType, Error>) -> Void) {
        self.request(route: route) { [weak self] (result: Result<Data, Error>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let resultData):
                do {
                    let resultTypeInstance = try self.parser.parse(data: resultData, toType: ParsableType.self)
                    completion(.success(resultTypeInstance))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
