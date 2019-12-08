//
//  MoviesView.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 01/12/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit

class MoviesView:UIView{
    
    var collectionView:UICollectionView?
    let layout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setCollectionView()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionView(){
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.estimatedItemSize = CGSize(width: self.frame.width/2.05, height: self.frame.height/4)
        layout.sectionInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        layout.sectionInsetReference = .fromSafeArea
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
    }
    
    func setUpView(){
        
        let viewWidth = self.frame.width
        let viewHeight = self.frame.height
        
        self.addSubview(collectionView!)
        
        self.setUpContraint(pattern: "H:|[v0(\(viewWidth))]", views: collectionView!)
        self.setUpContraint(pattern: "V:|[v0(\(viewHeight))]", views: collectionView!)
        
    }
}
