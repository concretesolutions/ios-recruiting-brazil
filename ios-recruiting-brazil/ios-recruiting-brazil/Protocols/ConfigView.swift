//
//  ConfigView.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
protocol ConfigView {
    func createViewHierarchy()
    func addConstraints()
    func setAdditionalConfiguration()
    func setView()
}

extension ConfigView {
    func setAdditionalConfiguration() {

    }
    func setView() {
        createViewHierarchy()
        addConstraints()
        setAdditionalConfiguration()
    }
}
