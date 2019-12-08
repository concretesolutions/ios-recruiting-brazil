//
//  feedSelecionado.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

protocol feedSelecionado: class {
    func didSelect(filme: Filme)
    func puxarProximaPagina(index: IndexPath)
}
