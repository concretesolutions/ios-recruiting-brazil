//
//  UIColor+Extension.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    convenience init(red:Int, green:Int, blue:Int, alpha:CGFloat){
        let r = CGFloat(red)/255.0
        let g = CGFloat(green)/255.0
        let b = CGFloat(blue)/255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
}
