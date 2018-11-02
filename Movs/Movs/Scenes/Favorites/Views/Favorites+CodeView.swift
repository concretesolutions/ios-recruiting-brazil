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
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(64)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
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
