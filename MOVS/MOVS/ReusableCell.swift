//
//  ReusableCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

protocol ReusableCell {
}

extension ReusableCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
