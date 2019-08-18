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
    
    lazy var loadRoll: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView(frame: .zero)
       view.tintColor = .red
       return view
    }()
    
    lazy var errorLabel: UILabel = {
        let view = UILabel()
        view.text = "Loading movies."
        view.font = UIFont.systemFont(ofSize: 50)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .black
        view.isHidden = true
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
        addSubview(errorLabel)
        addSubview(loadRoll)
        bringSubviewToFront(loadRoll)
    }
    
    func setupConstrains() {
        gridView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        loadRoll.snp.makeConstraints { (make) in
            make.right.left.top.bottom.equalToSuperview()
        }

    }
    
    func setupAdditionalConfiguration() {
        gridView.backgroundColor = UIColor(red: 247/255, green: 206/255, blue: 190/255, alpha: 1)
        gridView.register(MovieGridCell.self, forCellWithReuseIdentifier: MovieGridCell.reuseIdentifier)
    }
}

