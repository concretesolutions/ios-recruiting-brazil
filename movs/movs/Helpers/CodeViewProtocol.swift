//
//  CodeViewProtocol.swift
//  movs
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
        self.setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
