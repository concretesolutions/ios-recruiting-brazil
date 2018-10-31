//
//  MovieGridCollectionView.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class MovieGridView: UIView {
    
    let dataSource: UICollectionViewDataSource
    
    // UI Elements
    lazy var collection: UICollectionView = {
        let collection = MovieGridCollectionView()
        
        return collection
    }()
    
    lazy var errorView: MovieGridErrorView = {
        return MovieGridErrorView()
    }()
    
    
    // Initialization
    init(dataSource: UICollectionViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        self.setup()
        self.collection.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieGridView: ViewCode {
    
    public func addView() {
        self.addSubview(self.collection)
        self.addSubview(self.errorView)
    }
    
    public func addConstraints() {
        self.collection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

