//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case unknown
    case missingURL
    case noJson
    case parsingError
    case apiError
    
}
