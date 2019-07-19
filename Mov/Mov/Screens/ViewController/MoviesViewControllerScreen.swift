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
        let view = UICollectionView(frame: .zero, collectionViewLayout: layoutCell)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
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
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}

