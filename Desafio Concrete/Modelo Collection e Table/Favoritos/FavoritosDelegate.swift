//
//  FavoritosDelegate.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class favoritosTableViewDelegate: NSObject, UITableViewDelegate {
    
    var elementos: [Filme]
    
    init(elementos: [Filme]){
        self.elementos = elementos
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Desfavoritar"
    }

}
