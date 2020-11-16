//
//  Filme.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 07/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit

class Filme: NSObject {
    
    let id: String
    let titulo: String
    let image: String
    let ano: String
    let genero: [Any]
    
    init(id: String, titulo: String, image: String, ano: String, genero: Array<Int>) {
        self.id = id
        self.titulo = titulo
        self.image = image
        self.ano = ano
        self.genero = genero
    }
    
}
