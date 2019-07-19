//
//  MoviesViewControllerScreen.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit
import SnapKit

class MoviesViewControllerScreen: UIView {
    
    
    lazy var layoutCell = MovieCollectionViewCellScreen()
    
    
    lazy var movieCollectionView: UICollectionView = {
 
        let view = UICollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = UIColor.white
        
        
        
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


extension MoviesViewControllerScreen: CodeView{
    
    func buidViewHirarchy() {
        addSubview(movieCollectionView)
    }
    
    func setupContraints() {
        movieCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
        
        
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}

