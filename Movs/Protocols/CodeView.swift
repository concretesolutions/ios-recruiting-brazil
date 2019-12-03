//
//  CodeViewDelegate.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

@objc protocol CodeView {
    @objc optional func buildViewHierarchy()
    @objc optional func setupConstraints()
    @objc optional func setupAdditionalConfiguration()
}

extension CodeView {
    func setupView() {
        if let buildViewHierarchy = self.buildViewHierarchy {
            buildViewHierarchy()
        }
        
        if let setupConstraints = self.setupConstraints {
            setupConstraints()
        }
        
        if let setupAdditionalConfiguration = self.setupAdditionalConfiguration {
            setupAdditionalConfiguration()
        }
    }
}
