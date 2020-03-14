//
//  ResponseError.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case rede
    case decoding
    
    var reason: String {
        switch self {
        case .rede:
            return "Ocorreu um erro ao receber os dados da rede. Verifique sua conexão e arraste a tela para baixo para atualizar"
        case .decoding:
            return "Ocorreu um erro ao decodificar os dados da rede. Tente novamente mais tarde."
        }
    }
}
