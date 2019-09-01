//
//  ColorScheme.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/18/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

enum UsedColors {
    case black
    case gold
    
    var color: UIColor{
        switch self {
            case .black:
                return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
            
            case .gold:
                return UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
            
        }
    }
}
