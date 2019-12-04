//
//  CodeViewDelegate.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

@objc protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    @objc optional func setupAdditionalConfiguration()
}

extension CodeView {
    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
        
        if let setupAdditionalConfiguration = self.setupAdditionalConfiguration {
            setupAdditionalConfiguration()
        }
    }
}
