//
//  RoundedButton.swift
//  Movs
//
//  Created by Adann Simões on 22/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    @IBInspectable var isRounded: Bool = false {
        didSet {
            switch isRounded {
            case true:
                applyRoundedCorner()
            case false:
                return
            }
        }
    }
    
    func applyRoundedCorner() {
        self.layer.cornerRadius = 8
    }
}
