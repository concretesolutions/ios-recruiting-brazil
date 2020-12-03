//
//  ManageFavorites.swift
//  Movs
//
//  Created by Gabriel Coutinho on 02/12/20.
//

import Foundation

protocol GerenciarFavoritosUseCase {
    func getFavoritos(em context: NSObject) -> [Int]
    func favoritar(filme: Media, em context: NSObject)
    func desfavoritar(filme: Media, em context: NSObject)
}

class GerenciarFavoritos: GerenciarFavoritosUseCase {
    
    func getFavoritos(em context: NSObject) -> [Int] {
        return Media.getIdsFavoritos(em: context)
    }
    
    func favoritar(filme: Media, em context: NSObject) {
        do {
            try filme.salvarNosFavoritos(em: context)
        } catch {
            return
        }
    }
    
    func desfavoritar(filme: Media, em context: NSObject) {
        guard let id = filme.id else { return }
        do {
            try filme.removerDosFavoritos(id, em: context)
        } catch {
            return
        }
    }
}
