//
//  File.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 21/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

protocol ViewCode where Self: UIView {
    init(frame: CGRect)

    func setup()
    func setupSubviews()
    func setupLayout()
}

extension ViewCode {
    func setup() {
        setupSubviews()
        setupLayout()
    }
}
