//
//  CodeView.swift
//  app
//
//  Created by rfl3 on 15/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView: class {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupLayout()
}

extension CodeView {
    func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
