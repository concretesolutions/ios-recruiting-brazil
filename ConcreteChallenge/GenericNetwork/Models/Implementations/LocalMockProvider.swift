//
//  LocalMockProvider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A provider that simulates requesting, while reading from a local file. It also can send intentional errors at the completion
public class LocalMockProvider<ParserType: Parser>: ParserProvider {
    public var parser: ParserType
    public var error: Error?
    
    /// Initilized the provider
    /// - Parameters:
    ///   - parser: the parser to use with the provider dara result
    ///   - error: a error to be used when simulating intentional errors for unit testing.
    public init(parser: ParserType, error: Error? = nil) {
        self.parser = parser
        self.error = error
    }
    
    public func request(route: Route, completion: @escaping (Result<Data, Error>) -> Void) -> CancellableTask? {
        
        // if there is a error, only completes with it.
        if let error = self.error {
            completion(.failure(error))
            return nil
        }
        
        guard route.method == .get else {
            fatalError("MockProvider doesnt support \(route.method.rawValue) method yet")
        }
        
        let routeURL = route.baseURL
        
        do {
            let resultData = try Data(contentsOf: routeURL)
            completion(.success(resultData))
        } catch {
            completion(.failure(error))
        }
        
        return nil
    }
}
