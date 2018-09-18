//
//  UIView+Utils.swift
//  Pedida de Hoje
//
//  Created by Jonathan Martins on 22/06/18.
//  Copyright © 2018 Jussi. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius  = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
