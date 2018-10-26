//
//  CodeView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
