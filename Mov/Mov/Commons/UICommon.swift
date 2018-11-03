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
        let alert = UIAlertController(title: "Erro", message: "Um erro ocorreu. Por favor, tente esta ação mais tarde", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
        
        return alert
    }
}
