//
//  CodeView.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//
import Foundation
protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}
extension CodeView{
    func setupView(){
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
