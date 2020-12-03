//
//  ManageFavorites.swift
//  Movs
//
//  Created by Gabriel Coutinho on 02/12/20.
//

import Foundation

protocol GerenciarFavoritosUseCase {
    func favoritar(filme: Media, em context: NSObject)
    func desfavoritar(filme: Media, em context: NSObject)
}

class GerenciarFavoritos: GerenciarFavoritosUseCase {
    
    func favoritar(filme: Media, em context: NSObject) {
        do {
            try filme.salvarNosFavoritos(em: context)
        } catch {
            return
        }
    }
    
    func desfavoritar(filme: Media, em context: NSObject) {
        debugPrint("desfavoritei \(filme.title)")
    }
}
