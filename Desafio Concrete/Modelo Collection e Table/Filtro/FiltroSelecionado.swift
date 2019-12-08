//
//  FiltroSelecionado.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

enum TipoFiltroSelecionado {
    case genero
    case ano
}

protocol filtroSelecionadoDelegate: class {
    func didSelect(filtro: Any, tipoFiltro: TipoFiltroSelecionado)
}
