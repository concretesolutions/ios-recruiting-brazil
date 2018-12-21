//
//  String + Height.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 21/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
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
