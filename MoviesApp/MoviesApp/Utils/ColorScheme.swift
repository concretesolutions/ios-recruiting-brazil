//
//  ColorScheme.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/18/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

enum UsedColor {
    case blue
    case yellow
    case brown
    
    var color: UIColor{
        switch self {
            case .blue:
                return UIColor(red: 45/255, green: 48/255, blue: 71/255, alpha: 1)
            
            case .yellow:
                return UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
            
            case .brown:
                return UIColor(red: 217/255, green: 151/255, blue: 30/255, alpha: 1)
        }
    }
}
