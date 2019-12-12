//
//  HTTPTask.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
public typealias Parameters = [String: Any]

public enum HTTPTask {
    case requestPlain
    case requestParameters(Parameters)
    case requestWithBody(Encodable)
}
