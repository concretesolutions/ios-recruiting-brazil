//
//  Fonts.swift
//  Movs
//
//  Created by Gabriel Reynoso on 24/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

enum Fonts:String {
    case futuraBold = "Futura-Bold"
    
    func font(size:CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
