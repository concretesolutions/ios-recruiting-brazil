//
//  ReusableIdentifier.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

protocol ReusableIdentifier {
    
    static var storyBoardIdentifier: String { get }
    
}

extension ReusableIdentifier {
    
    static var storyBoardIdentifier: String {
        return String(describing: self)
    }
    
}

