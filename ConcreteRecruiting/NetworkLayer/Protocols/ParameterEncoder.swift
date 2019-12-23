//
//  ParameterEncoder.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(_ request: inout URLRequest, with parameters: Parameters) throws
}
