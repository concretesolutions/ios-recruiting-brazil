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
    func setupView()
}

extension ViewCode {
    func autolayout() {}
    func additionalSetups() {}
    func setupView() {
        self.design()
        self.autolayout()
        self.additionalSetups()
    }
}

protocol ReusableViewCode: ViewCode {
    var settedUp:Bool { get set }
}

extension ReusableViewCode {
    func setupView() {
        if !self.settedUp {
            self.design()
            self.autolayout()
            self.additionalSetups()
            self.settedUp = true
        }
    }
}
