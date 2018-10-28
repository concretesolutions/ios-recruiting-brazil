//
//  UIScreen + widthProportion.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

import UIKit

extension UIScreen {
    
    static let iPhone6Width: CGFloat = 375
    static let iPhone6Height: CGFloat = 667
    
    static var widthProportion: CGFloat { return main.bounds.width/iPhone6Width }
    
    static var heightProportion: CGFloat { return main.bounds.height/iPhone6Height }
}
