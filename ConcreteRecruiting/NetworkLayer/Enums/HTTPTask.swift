//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]

public enum HTTPTask {
    
    case requestPlain
    case requestUrlParameters(Parameters)
    case requestBodyParameters(Parameters)
    case requestUrlBodyParameters(Parameters)
    
}
