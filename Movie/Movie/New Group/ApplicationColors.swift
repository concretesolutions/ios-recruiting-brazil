//
//  ApplicationColors.swift
//  Movie
//
//  Created by Elton Santana on 15/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit

enum ApplicationColors {
    case yellow, blue, red, gray
    
    var uiColor: UIColor {
        switch self {
        case .yellow:
            return UIColor(red: 236/255, green: 205/255, blue: 99/255, alpha: 1)
        case .blue:
            return UIColor(red: 50/255, green: 51/255, blue: 72/255, alpha: 1)
        case .red:
            return UIColor(red: 180/255, green: 16/255, blue: 15/255, alpha: 1)
        case .gray:
            return UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        }
    }
}
