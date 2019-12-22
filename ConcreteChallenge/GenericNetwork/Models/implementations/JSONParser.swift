//
//  JSONParser.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// Parses JSON Data to Swift objects using JSONDecoder. The ParsableType needs to be Codable to be parsed.
public struct JSONParser<ParsableType: Decodable>: Parser {
    let jsonDecoder: JSONDecoder
    
    /// Initilizes the JSONParser with a jsonDecoder
    /// - Parameter jsonDecoder: the json decoder used to decode the Data.
    public init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }
    
    /// It converts JSON Data in Swift objects
    /// - Parameters:
    ///   - data: the JSON Data
    ///   - type: a Codable type
    public func parse(data: Data, toType type: ParsableType.Type) throws -> ParsableType {
        let typeInstance = try jsonDecoder.decode(type, from: data)
        return typeInstance
    }
}
