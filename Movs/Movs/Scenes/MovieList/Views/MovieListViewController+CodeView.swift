//
//  MovieListViewController+CodeView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 27/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

extension MovieListViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(64)
            make.height.equalTo(45)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        
        if let textFieldSearch = searchBar.value(forKey: "_searchField") as? UITextField {
            textFieldSearch.backgroundColor = UIColor.Movs.darkYellow
        }
    }
}

