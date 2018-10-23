//
//  Colors.swift
//  Movs
//
//  Created by Gabriel Reynoso on 22/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

enum Colors: String {
    case mainYellow = "Main Yellow"
    case darkBlue = "Dark Blue"
    case orange = "Orange"
    case white
    
    var color:UIColor {
        if self == .white {
            return .white
        } else {
            return UIColor(named:self.rawValue)!
        }
    }
}
