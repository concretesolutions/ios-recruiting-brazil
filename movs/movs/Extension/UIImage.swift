//
//  UIImage.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

extension UIImage {
    static var checkIcon = UIImage(named: "check_icon")
    static var favoriteEmptyIcon = UIImage(named: "favorite_empty_icon")
    static var favoriteFullIcon = UIImage(named: "favorite_full_icon")
    static var favoriteGrayIcon = UIImage(named: "favorite_gray_icon")
    static var filterIcon = UIImage(named: "FilterIcon")
    static var listIcon = UIImage(named: "list_icon")
    static var searchIcon = UIImage(named: "search_icon")
    static var error = UIImage(named: "cancel")
    
    var base64EncodedString: String? {
        return jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

