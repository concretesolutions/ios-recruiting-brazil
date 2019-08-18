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
    case pink
    case purple
    case green
    
    var color: UIColor{
        switch self {
            case .blue:
                return UIColor(red: 190/255, green: 231/255, blue: 247/255, alpha: 1)

            case .pink:
                return UIColor(red: 247/255, green: 206/255, blue: 190/255, alpha: 1)
            
            case .purple:
                return UIColor(red: 206/255, green: 190/255, blue: 274/255, alpha: 1)
            
            case .green:
                return UIColor(red: 231/255, green: 247/255, blue: 190/255, alpha: 1)
        }
    }
}
