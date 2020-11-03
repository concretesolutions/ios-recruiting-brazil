//
//  UIImage+Extension.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

public extension UIImage {
    enum Assets: String {
        case arrowBack = "arrow_back"
        case arrowForward = "arrow_forward"
        case checkIcon = "check_icon"
        case error = "error"
        case favoriteEmptyIcon = "favorite_empty_icon"
        case favoriteFullIcon = "favorite_full_icon"
        case favoriteGrayIcon = "favorite_gray_icon"
        case filterIcon = "filter_icon"
        case listIcon = "list_icon"
        case placeholder = "placeholder"
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

    func resize(size: CGSize) -> UIImage? {
        let hasAlpha = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }
}
