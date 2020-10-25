//
//  UIImage+Assets.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

extension UIImage {
    enum Assets: String {
        case checkIcon = "check_icon"
        case favoriteEmptyIcon = "favorite_empty_icon"
        case favoriteFullIcon = "favorite_full_icon"
        case favoriteGrayIcon = "favorite_gray_icon"
        case filterIcon = "filter_icon"
        case listIcon = "list_icon"
        case searchIcon = "search_icon"
    }

    convenience init?(assets identifier: Assets) {
        self.init(named: identifier.rawValue, in: Bundle.main, compatibleWith: nil)
    }
}
