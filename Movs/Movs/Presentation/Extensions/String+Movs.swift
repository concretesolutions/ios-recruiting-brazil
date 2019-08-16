//
//  String+Height.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func height(width: CGFloat, widthOffset: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width - widthOffset, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}

extension String {

    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
