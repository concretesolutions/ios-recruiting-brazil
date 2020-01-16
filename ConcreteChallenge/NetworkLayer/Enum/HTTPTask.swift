//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

public enum HTTPTask {
    case requestPlain
    case requestBodyParameters(Encodable)
    case requestURLParameters([String : CustomStringConvertible])
}
