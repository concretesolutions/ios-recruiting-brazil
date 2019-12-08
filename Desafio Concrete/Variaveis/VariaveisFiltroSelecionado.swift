//
//  VariaveisFiltroSelecionado.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

class VariaveisFiltroSelecionado {
    var tipoFiltro: String = ""
    var filtroDataSource: filtroTableViewDataSource?
    var filtroDelegate: filtroTableViewDelegate?
    var anos: [Int] = []
    var generos: [String] = []
    var anoAtual = 2019
    var delegate: voltarFiltro?
    var ano: Int? = nil
    var genero: String? = nil
}
