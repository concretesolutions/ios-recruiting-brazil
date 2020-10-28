//
//  UIImage+Extension.swift
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

    // MARK: - Initializers

    convenience init?(assets identifier: Assets) {
        self.init(named: identifier.rawValue, in: Bundle.main, compatibleWith: nil)
    }

    // MARK: - Functions

    func withInsets(insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left + insets.right, height: self.size.height + insets.top + insets.bottom)
        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        return imageWithInsets
    }
}
