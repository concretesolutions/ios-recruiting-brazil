//
//  ResponseError.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case rede
    case decoding
    
    var reason: String {
        switch self {
        case .rede:
            return "Ocorreu um erro ao receber dados"
        case .decoding:
            return "Ocorreu um erro ao decodificar dados"
        }
    }
}
