//
//  SearchBar.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    
    var textChanged: ((String) -> ())?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension SearchBar: CodeView {
    func buildViewHierarchy() {}
    func setupConstraints() {}
    
    func setupAdditionalConfiguration() {
        barTintColor = UIColor.Movs.yellow
        layer.borderWidth = 1
        layer.borderColor = UIColor.Movs.yellow.cgColor
        placeholder = "Search"
        delegate = self
        
        if let textFieldSearch = value(forKey: "_searchField") as? UITextField {
            textFieldSearch.backgroundColor = UIColor.Movs.darkYellow
        }
    }
}
