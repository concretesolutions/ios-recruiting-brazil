//
//  MovieView.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class MoviesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundView?.backgroundColor = UIColor(red: 25/255, green: 23/255, blue: 22/255, alpha: 1)
        return cv
    }()
    
    func setupView(){
        addSubview(collectionView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: collectionView)
    }
    
}
