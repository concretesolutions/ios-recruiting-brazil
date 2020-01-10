//
//  UIImage+CustomIcons.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

extension UIImage {
    static let placeholder = UIImage(named: "placeholder")!

    static let listIcon = UIImage(named: "list_icon")!
        .withRenderingMode(.alwaysTemplate)

    struct Favorite {
        static let emptyIcon = UIImage(named: "favorite_empty_icon")!
            .withRenderingMode(.alwaysTemplate)
        static let fullIcon = UIImage(named: "favorite_full_icon")!
            .withRenderingMode(.alwaysTemplate)
        static let grayIcon = UIImage(named: "favorite_gray_icon")!
            .withRenderingMode(.alwaysTemplate)
    }
}
