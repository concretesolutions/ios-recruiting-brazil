//
//  EmptyState.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation


public enum EmptyState {
    case networkError
    case noResults
    case noData
    case loading
    case none
    
    var description: String? {
        switch self {
            case .networkError: return "Houve um erro com sua conexão com a internet"
            case .noResults: return "Não foi possível buscar nada"
        case .noData: return "Nenhum registro"
            case .loading: return "Carregando informações"
            case .none: return nil
        }
    }
    
    var imagePath: String? {
        switch self {
            case .networkError: return "network"
            case .noResults: return "results"
            case .noData: return "box"
            case .loading: return "loading"
            case .none: return nil
        }
    }
}
