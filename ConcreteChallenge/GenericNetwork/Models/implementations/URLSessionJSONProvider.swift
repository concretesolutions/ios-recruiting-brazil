//
//  URLSessionJSONProvider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// Specialization of URLSessionProvider with JSONParser as Parser to be easier to use the provider.
public class URLSessionJSONParserProvider<ParsableType: Codable>: URLSessionParserProvider<JSONParser<ParsableType>> {
    public init() {
        super.init(parser: JSONParser())
    }
}
