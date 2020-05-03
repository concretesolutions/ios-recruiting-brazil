//
//  Theme.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 27/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//
import UIKit

enum Theme {

    static let coverRatio: Float = {
        return 720 / 500
    }()

    static let paddingHorizontal: CGFloat = {
        return 16
    }()

    static let paddingVertical: CGFloat = {
        return 8
    }()

    static let sectionTitleFont: UIFont = {
        return UIFont(name: "Avenir-Black", size: 28)!
    }()

    static let sectionBodyFont: UIFont = {
        return UIFont(name: "Avenir", size: 14)!
    }()

    static let starImage: UIImage = {
        let image = UIImage(named: "star")
        return image!
    }()

    static let playImage: UIImage = {
        let image = UIImage(named: "play")
        return image!
    }()

    static let heart: UIImage = {
        let image = UIImage(named: "heart")
        return image!
    }()

    static let heartFull: UIImage = {
        let image = UIImage(named: "heartFull")
        return image!
    }()

}
