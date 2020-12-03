//
//  BuscarImagem.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation

protocol BuscarImagemUseCase {
    func com(path: String, _ completionHandler: @escaping (Data?) -> Void)
}

class BuscarImagem: BuscarImagemUseCase {
    private let api: TheMovieDBAPI
    
    init() {
        api = API()
    }
    
    func com(path: String, _ completionHandler: @escaping (Data?) -> Void) {
        api.getImage(path: path, completionHandler)
    }
}
