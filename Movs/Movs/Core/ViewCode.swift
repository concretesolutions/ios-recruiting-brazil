//
//  ViewCode.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol ViewCode: NSObjectProtocol {
    func design()
    func autolayout()
    func additionalSetups()
}

extension ViewCode {
    func autolayout() {}
    func additionalSetups() {}
    func setup() {
        self.design()
        self.autolayout()
        self.additionalSetups()
    }
}
