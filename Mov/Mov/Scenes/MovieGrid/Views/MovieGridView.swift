//
//  MovieGridCollectionView.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class MovieGridView: UIView {
    
    let searchBarDelegate: MovieSearchBarDelegate = MovieSearchBarDelegate()
    
    // UI Elements
    lazy var collection: UICollectionView = {
        let collection = MovieGridCollectionView()
        
        return collection
    }()
    
    lazy var networkErrorView: ErrorView = {
        return ErrorView(errorImage: Images.error, labelText: Texts.movieGridError)
    }()
    
    lazy var noResultsView: ErrorView = {
        return ErrorView(errorImage: Images.noResults, labelText: Texts.noResults(for: "x"))
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        return activityIndicator
    }()
    
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
    
    
    // Initialization
    init() {
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
        self.addSubview(self.networkErrorView)
        self.addSubview(self.searchBar)
        self.addSubview(self.noResultsView)
        self.addSubview(activityIndicator)
    }
    
    public func addConstraints() {
        self.collection.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp_bottomMargin)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.networkErrorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
            make.centerX.equalToSuperview()
        }
        
        self.noResultsView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp_bottomMargin)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

