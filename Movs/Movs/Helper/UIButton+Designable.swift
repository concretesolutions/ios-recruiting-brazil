
//
//  UIButton+Custom.swift
//  Movs
//
//  Created by Maisa on 01/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
