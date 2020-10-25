//
//  ViewCode.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol ViewCode {
    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }
}
