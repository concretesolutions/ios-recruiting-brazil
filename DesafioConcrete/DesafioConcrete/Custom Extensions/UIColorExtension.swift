//
//  UIColorExtension.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    static var customYellow: UIColor { return UIColor.fromIntRGB(red: 247.0, green: 206.0, blue: 91.0) }
    
    static func fromIntRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
           
           let r =  (red * 1) / 255.0
           let g = (green * 1) / 255.0
           let b = (blue * 1) / 255.0
           let a = CGFloat(1.0)
           
           return UIColor(red: r, green: g, blue: b, alpha: a)
           
       }
    
}
