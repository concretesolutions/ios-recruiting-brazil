//
//  Favorites+CodeView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

extension FavoritesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.insertSubview(removeFilterButton, belowSubview: searchBar)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(64)
            make.height.equalTo(45)
        }
        
        removeFilterButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(0)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(removeFilterButton.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag
    }
}
