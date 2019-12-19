//
//  LayoutProxy+constraintsFillMethods.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

extension LayoutPropertyProxy {
    func equalToSuperView() {
        self.layout.equal(toView: nil, type: self.type, operation: .margin(0))
    }
}
