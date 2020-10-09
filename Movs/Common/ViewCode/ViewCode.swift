//
//  ViewCode.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation
import SketchKit

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCode {

    func setupBaseView() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }

    func configureViews() {
    }
}
