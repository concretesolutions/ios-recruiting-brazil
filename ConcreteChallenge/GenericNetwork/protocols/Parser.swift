//
//  Parser.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A protocol for types that can parse Data values.
/// This protocol can be implemented for parsing any Data format like: JSON and XML
public protocol Parser {
    //the result type from the parser
    associatedtype ParsableType
    
    /// converts a data to a ParsableType
    /// - Parameters:
    ///   - data: the data to convert
    ///   - type: a ParsableType instance
    func parse(data: Data, toType type: ParsableType.Type) throws -> ParsableType
}
