//
//  FontExtension.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

extension UIFont {
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
    
    static func light(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Light", size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size)!
    }
}
