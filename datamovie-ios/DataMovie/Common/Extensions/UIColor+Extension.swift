//
//  UIColor+Extension.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

//
//  UIColor+Extension.swift
//  MinhaOi
//
//  Created by Andre Souza on 23/03/18.
//

import Foundation
import UIKit

public extension UIColor {
    
    var hue: CGFloat {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return hue
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }

    var luminance: CGFloat {
        let (red, green, blue, _) = rgba
        return (0.2126 * red) + (0.7152 * green) + (0.0722 * blue)
    }
    
    var isLight: Bool {
        return luminance >= 0.6
    }
    
//    var isLight: Bool {
//        var white: CGFloat = 0
//        getWhite(&white, alpha: nil)
//        return white > 0.5
//    }
    
    var brightPercent: CGFloat {
        guard let components = cgColor.components, components.count > 2 else { return 0 }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness
    }
    
    func lighter(by percentage: CGFloat = 50.0) -> UIColor {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 50.0) -> UIColor {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return self
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(colorHex:Int) {
        self.init(red:(colorHex >> 16) & 0xff, green:(colorHex >> 8) & 0xff, blue:colorHex & 0xff)
    }
    
    static let blueColor = UIColor(colorHex:0x34428C)
    static let navigationColor = UIColor(colorHex: 0x202537)
    static let backgroundColor = UIColor(colorHex:0x191F39)
    static let backgroundColorDarker = UIColor(colorHex:0x0F152B)
    static let unselectedTextColor = UIColor(colorHex:0xB1B1B1)
    static let green = UIColor(colorHex:0x11935B)
    static let red = UIColor(colorHex: 0xE5423A)
    
}
