//
//  VariaveisOpcoesFiltro.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

class VariaveisOpcoesFiltro {
    let opcoes = ["Date", "Genre"]
    var anoSelecionado: Int? = nil
    var generoSelecionado: String? = nil
    var dataSource: opcoesFiltroTableViewDataSource!
    var filtroDelegate: opcoesFiltroTableViewDelegate!
    var delegate: voltarFiltro?
}
