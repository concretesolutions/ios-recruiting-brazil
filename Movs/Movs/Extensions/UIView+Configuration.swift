//
//  UIView+Configuration.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

protocol ViewConfiguration {
    func setupViews()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewConfiguration {
    func configureViews() {
        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    func setupViews() {}
    func setupHierarchy() {}
    func setupConstraints() {}
}
