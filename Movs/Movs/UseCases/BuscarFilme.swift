//
//  BuscarFilme.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation

protocol BuscarFilmeUseCase {
    func por(id: Int, _ completionHandler: @escaping (Media?) -> Void)
}

class BuscarFilme: BuscarFilmeUseCase {
    private let api: TheMovieDBAPI
    
    init() {
        api = API()
    }
    
    func por(id: Int, _ completionHandler: @escaping (Media?) -> Void) {
        let decoder = JSONDecoder()
        api.getMovie(id: id) { data in
            guard let data = data else { return }
            let media = try! decoder.decode(Media.self, from: data)
            completionHandler(media)
        }
    }
}
