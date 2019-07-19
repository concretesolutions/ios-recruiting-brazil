//
//  MovieCollectionViewCellScreen.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

final class MovieCollectionViewCellScreen: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupView()
        
        self.itemSize = CGSize(width: 60, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension MovieCollectionViewCellScreen: CodeView{
    func buidViewHirarchy() {
        //adicionar view
        
    }
    
    func setupContraints() {
        // configurar constraints
        
        
        
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
    }
    
    
}

