//
//  UILabel+initWithText.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}
