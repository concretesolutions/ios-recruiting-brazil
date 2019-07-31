//
//  ColorPalette.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 28/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

 enum ColorPalette {
    case yellow
    case paleYellow
    case darkYellow
    case orange
    case blue
    case darkBlue
    case textGray
    case textBlack
    case background
    
}

extension ColorPalette {
    var uiColor: UIColor {
        
        switch self {
        case .yellow:
            return UIColor(red: 245/255, green: 199/255, blue: 1/255, alpha: 1)
        case .paleYellow:
            return UIColor(red: 220/255, green: 171/255, blue: 0/255, alpha: 1)
        case .darkYellow:
            return UIColor(red: 200/255, green: 151/255, blue: 0/255, alpha: 1)
        case .orange:
            return UIColor(red: 255/255, green: 175/255, blue: 1/255, alpha: 1)
        case .blue:
            return UIColor(red: 62/255, green: 111/255, blue: 246/255, alpha: 1)
        case .darkBlue:
            return UIColor(red: 0/255, green: 0/255, blue: 70/255, alpha: 1)
        case .textGray:
            return UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        case .textBlack:
            return UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        case .background:
            return UIColor(red: 245/255, green: 241/255, blue: 232/255, alpha: 1)
        }
    }
}

