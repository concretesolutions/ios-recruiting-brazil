//
//  ViewCode.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

protocol ViewCode {
    func buildViewHierarchy()
    func buildConstraints()
    func setupView()
}

extension ViewCode{
    func setupView() {
        buildViewHierarchy()
        buildConstraints()
        aditionalConfiguration()
    }
    
    func aditionalConfiguration() {
        
    }
}
