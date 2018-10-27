//
//  ViewCode.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


protocol ViewCode {
    func addView()
    func addConstraints()
    func aditionalSetup()
    func setup()
}

extension ViewCode {
    
    public func setup() {
        self.addView()
        self.addConstraints()
        self.aditionalSetup()
    }
    
    public func aditionalSetup() {}
}

