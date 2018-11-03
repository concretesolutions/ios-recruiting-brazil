//
//  UICommon.swift
//  Mov
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit


struct UICommon {
    private init() {}
    
    static var favoritesErrorAlert: UIAlertController {
        let alert = UIAlertController(title: "Erro", message: "A memória de Favoritos falhou. Nos perdoe.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
        
        return alert
    }
}
