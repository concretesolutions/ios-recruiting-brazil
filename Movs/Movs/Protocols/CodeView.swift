//
//  CodeView.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 05/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

protocol CodeView {
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
}
