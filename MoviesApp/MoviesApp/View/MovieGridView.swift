//
//  MovieGridView.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - The view basic configuration and visual elements
class MovieGridView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extension to define the cell constraints
extension MovieGridView: CodeView{
    func buildViewHierarchy() {
        addSubview(gridView)
    }
    
    func setupConstrains() {
        gridView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        gridView.backgroundColor = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
        gridView.register(MovieGridCell.self, forCellWithReuseIdentifier: MovieGridCell.reuseIdentifier)
    }
}

