//
//  BaseViewProtocol.swift
//  TheVargo
//
//  Created by Andre Souza on 09/07/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import Foundation

protocol BaseViewProtocol {
    func setupView()
    func updateViewsFromIB()
}

extension BaseViewProtocol {
    
    func updateViewsFromIB() {
        // this code will execute only in IB
        #if TARGET_INTERFACE_BUILDER
        setupView()
        #endif
    }
    
}
