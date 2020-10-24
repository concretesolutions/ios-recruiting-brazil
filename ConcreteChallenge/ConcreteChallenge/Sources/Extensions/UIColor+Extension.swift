//
//  UIColor+Extension.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

public extension UIColor {

    static let white = UIColor(hex: "FFFFFF")
    static let yellowLight = UIColor(hex: "F7CE5B")
    static let blackLight = UIColor(hex: "2D3047")
    static let orange = UIColor(hex: "D9971E")

    // MARK: - Initializers

    convenience init(hex: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0

        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch hex.count {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                alpha   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                red = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                green  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                blue = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                alpha = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                red   = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                blue  = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                red = 0.0
                green = 0.0
                blue = 0.0
            }
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
