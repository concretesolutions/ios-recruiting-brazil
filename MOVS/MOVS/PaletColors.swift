//
//  PaletColors.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

enum PaletColor{
    case darkBlue
    case oceanBlue
    case esmerald
    case pink
    case gray
}

extension PaletColor{
    var rawValue: UIColor {
        get {
            switch self{
            case .darkBlue:
                return UIColor(red: 27/255, green: 27/255, blue: 39/255, alpha: 1)
            case .oceanBlue:
                return UIColor(red: 38/255, green: 56/255, blue: 78/255, alpha: 1)
            case .esmerald:
                return UIColor(red: 16/255, green: 152/255, blue: 160/255, alpha: 1)
            case .pink:
                return UIColor(red: 236/255, green: 43/255, blue: 102/255, alpha: 1)
            case .gray:
                return UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
            }
        }
    }
}

