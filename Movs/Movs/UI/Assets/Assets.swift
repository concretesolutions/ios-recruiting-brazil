//
//  Assets.swift
//  Movs
//
//  Created by Gabriel Reynoso on 22/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

enum Assets: String {
    case checkIcon = "check_icon"
    case favoriteEmptyIcon = "favorite_empty_icon"
    case favoriteFillIcon = "favorite_full_icon"
    case favoriteGrayIcon = "favorite_gray_icon"
    case filterIcon = "FilterIcon"
    case listIcon = "list_icon"
    case searchIcon = "search_icon"
    
    var image:UIImage {
        return UIImage(named:self.rawValue)!
    }
}
