//
//  Protocols.swift
//  Movs
//
//  Created by Gustavo Caiafa on 22/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation

// Protocolo responsavel por devolver a data selecionada para a tela de Filtro
protocol didSelectDateFilterProtocol {
    func selectedDate(didSelect: Bool, date: Int?)
}

// Protocolo responsavel por devolver o genero selecionado para a tela de Filtro
protocol didSelectGenresFilterProtocol {
    func selectedGenre(didSelect: Bool, genre: String?)
}

// Protocolo responsavel por aplicar os filtros recebidos da tela de Filter na tela de Favorites
protocol didFilterProtocol{
    func selectedFilters(date: Int?, genre: String?)
}

