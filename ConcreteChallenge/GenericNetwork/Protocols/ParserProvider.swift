//
//  ParserProvider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A Provider convencience  sub-protocol that requests and parses in a same method. In the majority of the cases, this is used by the final application, because it makes the syntax a little shorter.
public protocol ParserProvider: AnyObject, Provider where ReturnType == Data {
    associatedtype ParserType: Parser
    
    // This parser is goint to be used when each of the requests be finished
    var parser: ParserType { get set }
        
    /// It requests Data from a Route and parses it with the parser instance
    func requestAndParse(route: Route, completion: @escaping (Result<ParserType.ParsableType, Error>) -> Void) -> CancellableTask?
}
