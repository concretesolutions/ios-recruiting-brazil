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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barTintColor = Colors.lightYellow
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = Colors.lightYellow.cgColor
        searchBar.placeholder = "search movies..."
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = Colors.darkYellow
        } else {/*do nothing*/}
        
        return searchBar
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
        self.addSubview(searchBar)
    }
    
    public func addConstraints() {
        self.collection.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp_bottomMargin)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.errorView.snp.makeConstraints { make in
            make.edges.equalTo(self.collection)
        }
        
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
            make.centerX.equalToSuperview()
        }
    }
}

