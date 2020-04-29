//
//  Theme.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 27/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//
import UIKit

enum ThemeConstants {
    case dev
    case staging
    case production
    
    var coverRatio: Float {
        return 720 / 500
    }
    
    var paddingHorizontal: CGFloat {
        return 16
    }
    
    var paddingVertical: CGFloat {
        return 8
    }
    
    var sectionTitleFont: UIFont {
        return UIFont(name: "Avenir-Black", size: 28)!
    }
    
    var sectionBodyFont: UIFont {
        return UIFont(name: "Avenir", size: 14)!
    }
    
    var starImage: UIImage {
        let image = UIImage(named: "star")
        return image!
    }
    
    var playImage: UIImage {
        let image = UIImage(named: "play")
        return image!
    }
    
    var heart: UIImage {
        let image = UIImage(named: "heart")
        return image!
    }
    
    var heartFull: UIImage {
        let image = UIImage(named: "heartFull")
        return image!
    }
    
}


