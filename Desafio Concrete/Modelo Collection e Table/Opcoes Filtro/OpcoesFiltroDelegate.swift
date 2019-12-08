//
//  OpcoesFiltroDelegate.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class opcoesFiltroTableViewDelegate: NSObject, UITableViewDelegate {
    
    let elementos: [Any]
    let delegate: opcoesFiltroSelecionadoDelegate
    
    init(elementos: [Any], delegate: opcoesFiltroSelecionadoDelegate) {
        self.elementos = elementos
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect(indexPath: indexPath)
    }
    
    
}
