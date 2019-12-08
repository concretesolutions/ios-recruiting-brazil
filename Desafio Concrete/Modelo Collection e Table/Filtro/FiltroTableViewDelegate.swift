//
//  FiltroTableViewDelegate.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class filtroTableViewDelegate: NSObject, UITableViewDelegate {
    
    let elementos: [Any]
    let tipoFiltro: TipoFiltroSelecionado
    let delegate: filtroSelecionadoDelegate
    
    init(elementos: [Any], tipoFiltro: TipoFiltroSelecionado, delegate: filtroSelecionadoDelegate) {
        self.elementos = elementos
        self.tipoFiltro = tipoFiltro
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        for cell in tableView.visibleCells {
            cell.accessoryType = .none
        }
        cell.accessoryType = .checkmark
        let filtro = elementos[indexPath.row]
        delegate.didSelect(filtro: filtro, tipoFiltro: tipoFiltro)
    }
    
    
}
