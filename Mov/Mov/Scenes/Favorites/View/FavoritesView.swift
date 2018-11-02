//
//  FavoritesView.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class FavoritesView: UIView {
    let searchBarDelegate: MovieSearchBarDelegate = MovieSearchBarDelegate()
    
    // UI Elements
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barTintColor = Colors.lightYellow
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = Colors.lightYellow.cgColor
        searchBar.placeholder = "search movies..."
        searchBar.delegate = self.searchBarDelegate
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = Colors.darkYellow
        } else {/*do nothing*/}
        
        
        return searchBar
    }()
    
    lazy var tableView: FavoritesTableView = {
        return FavoritesTableView(frame: .zero, style: .plain)
    }()
    
    lazy var noResultsView: ErrorView = {
        return ErrorView(errorImage: Images.noResults, labelText: Texts.noResults(for: "x"))
    }()
    
    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesView: ViewCode {
    
    public func addView() {
        self.addSubview(self.searchBar)
        self.addSubview(self.tableView)
        self.addSubview(self.noResultsView)
    }
    
    public func addConstraints() {
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
            make.centerX.equalToSuperview()
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp_bottomMargin)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.noResultsView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp_bottomMargin)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
}

