//
//  MovieGridCollectionView.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class MovieGridView: UIView {
    // UI Elements
    lazy var collection: UICollectionView = {
        let collection = MovieGridCollectionView()
        
        return collection
    }()
    
    
    // Initialization
    public init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieGridView: ViewCode {
    
    public func addView() {
        self.addSubview(self.collection)
    }
    
    public func addConstraints() {
        self.collection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

