//
//  LayoutProxy+constraintsFillMethods.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

extension LayoutPropertyProxy {
    /// it makes this Anchor property be equal to the superview
    func equalToSuperView() {
        self.layout.makeRelation(to: nil, type: self.type, operation: .margin(0))
    }
}
