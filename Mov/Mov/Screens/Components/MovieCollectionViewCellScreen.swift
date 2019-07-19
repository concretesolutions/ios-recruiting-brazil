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
        
        
        
        
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
    }
    
    
}



import UIKit
import SnapKit

final class MovieCollectionViewCellScreen2: UIView {
    
    var button: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = .red
        view.setTitle("Aperte", for: .normal)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension MovieCollectionViewCellScreen2: CodeView{
    func buidViewHirarchy() {
        //adicionar view
        
    }
    
    func setupContraints() {
        button.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
        
        
        
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
    }
    
    
}

