//
//  Colors.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 13/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

public enum Colors {
    case yellowNavigation, dark, darkYellow
    
    public var color: UIColor {
        switch self {
        case .yellowNavigation:
            return UIColor.spc_from(r: 247, g: 206, b: 91)
        case .dark:
            return UIColor.spc_from(r: 45, g: 48, b: 71)
        case .darkYellow:
            return UIColor.spc_from(r: 217, g: 151, b: 30)
        }
    }
}


extension UIColor {
    
    /// Takes integer values for Red, Green, and Blue channels to make
    /// creating colors from RGB a bit easier.
    ///
    /// Note: Assertions will fire during development if inappropriate values are passed.
    ///
    /// - Parameters:
    ///   - r: An integer between 0 and 255 representing the red channel value
    ///   - g: An integer between 0 and 255 representing the green channel value
    ///   - b: An integer between 0 and 255 representing the blue channel value
    ///   - a: A CGFloat between 0.0 and 1.0 representing the alpha (0.0 is transparent, 1.0 is opaque).
    /// - Returns: The created UIColor
    public static func spc_from(r: Int, g: Int, b: Int, a: CGFloat = 1.0) -> UIColor {
        assert((0 <= r && r <= 255), "Use a red value between 0 and 255!")
        assert((0 <= g && g <= 255), "Use a green value between 0 and 255!")
        assert((0 <= b && b <= 255), "Use a blue value between 0 and 255!")
        assert((0.0 <= a && a <= 1.0), "Use and alpha value between 0 and 1!")
        return UIColor(red: CGFloat(r) / 255.0,
                       green: CGFloat(g) / 255.0,
                       blue: CGFloat(b) / 255.0,
                       alpha: a)
    }
}
