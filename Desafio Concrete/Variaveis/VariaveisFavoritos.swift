//
//  VariaveisFavoritos.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

class VariaveisFavoritos {
    var anoSelecionado = 0
    var generoSelecionado = ""
    var pesquisaAtual = ""
    var requestFavoritos: RequestFavoritos!
    var dataSource: favoritosTableViewDataSource!
    var delegate: favoritosTableViewDelegate!
    var filmesFavoritados = [Filme]()
}
