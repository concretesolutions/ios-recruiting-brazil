//
//  AppColors.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//
//
//  AppColors.swift
//  Clicks!
//
//  Created by Leonel Menezes on 25/05/2018.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit
///Extension to help with the colors within the app
enum AppColors {
    case mainYellow
    case darkYellow
    case darkBlue

    private static let allValues = [mainYellow]

    var color: UIColor {
        switch self {
        case .mainYellow:
            return UIColor(colorWithHexValue: 0xF7CE5B)
        case .darkYellow:
            return UIColor(colorWithHexValue: 0xD9971D)
        case .darkBlue:
            return UIColor(colorWithHexValue: 0x2D3146)
        }
    }
}

///Helper init to work with hexadecimal color values
extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
