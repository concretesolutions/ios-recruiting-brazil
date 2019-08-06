//
//  Color.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 31/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

struct Color {
    static let gray = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
    static let white = UIColor.white
    static let black = UIColor.black
    static let oldPaper = UIColor(red: 223/255, green: 208/255, blue: 177/255, alpha: 1)
    static let scarlet = UIColor(red: 111/255, green: 5/255, blue: 21/255, alpha: 1)
    static let darkscarlet = UIColor(red: 36/255, green: 8/255, blue: 8/255, alpha: 1)
    static let lightgray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    static let scarletNoAlpha = UIColor(red: 111/255, green: 5/255, blue: 21/255, alpha: 0.2)
}

/**
 Color for cell cases
 */
enum TitleColors{
    case favorite
    case normal
    
    func dictionary()->[String:UIColor]{
        switch self {
        case .favorite:
            return ["background":Color.scarlet,"title":Color.lightgray]
        default:
            return ["background":Color.lightgray,"title":Color.black]
        }
    }
}
