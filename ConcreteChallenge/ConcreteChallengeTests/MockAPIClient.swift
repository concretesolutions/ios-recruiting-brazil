//
//  MockAPIClient.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

final class MockApiClient {
    static func loadJSONDataFromFile(filePath: String, completion: @escaping (Result<Data, Error>) -> ()) {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                completion(.success(data))
                
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }
}
