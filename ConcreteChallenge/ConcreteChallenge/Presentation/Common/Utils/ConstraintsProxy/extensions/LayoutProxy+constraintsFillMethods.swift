//
//  LayoutProxy+constraintsFillMethods.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension LayoutPropertyProxy {
    /// it makes this Anchor property be equal to the superview
    func equalToSuperView(margin: CGFloat = 0) {
        self.layout.makeRelation(to: nil, type: self.type, operation: .margin(margin))
    }
}
