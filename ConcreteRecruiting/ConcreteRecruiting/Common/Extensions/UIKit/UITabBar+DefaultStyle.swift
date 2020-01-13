//
//  UITabBar.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 12/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

extension UITabBar {
        
    func applyDefaultStyle() {
    
        self.isTranslucent = false
        self.shadowImage = UIImage()
        
        self.barTintColor = UIColor(named: "MainYellow")
        self.tintColor = UIColor(named: "CellBlue")
     
    }
        
}
