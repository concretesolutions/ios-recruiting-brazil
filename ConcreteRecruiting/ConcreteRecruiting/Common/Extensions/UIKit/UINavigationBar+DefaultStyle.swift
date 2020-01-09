//
//  UINavigationBar+DefaultStyle.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func applyDefaultStyle() {
    
        self.isTranslucent = false
        self.shadowImage = UIImage()
        
        self.barTintColor = UIColor(named: "MainYellow")
        self.tintColor = UIColor(named: "CellBlue")
     
    }
    
}
