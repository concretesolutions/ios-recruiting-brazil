//
//  ViewCode.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

protocol ViewCode{
    
    func setupViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    
}

extension ViewCode{
    
    func setupView(){
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
}
