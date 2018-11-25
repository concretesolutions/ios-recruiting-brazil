//
//  PopularMoviesScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class PopularMoviesScreen: UIView {
    
    lazy var collectionView:MoviesCollectionView = {
        let view = MoviesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptySearchView:GenericErrorView = {
//        var view = EmptySearchView(error: .generic)
        var view = GenericErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(searchController:UISearchController){
        searchController.searchBar.tintColor = Palette.blue
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.placeholder = "Search for Movies..."
    }
    
    func refreshUI(with state: PresentationState){
        switch state{
        case .initial:
            print("initial")
        case .loading:
            self.bringSubviewToFront(activityIndicator)
            self.activityIndicator.startAnimating()
            self.emptySearchView.isHidden = true
        case .ready:
            self.activityIndicator.stopAnimating()
            self.emptySearchView.isHidden = true
        case .error:
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.emptySearchView.setupView(for: .generic)
                self?.emptySearchView.isHidden = false
                self?.bringSubviewToFront((self?.emptySearchView)!)
            }
            
        case .noResults(let query):
            emptySearchView.setupView(for: .noResults, with: query)
            self.activityIndicator.stopAnimating()
            self.bringSubviewToFront(emptySearchView)
            self.emptySearchView.isHidden = false
        }
    }
    
}

extension PopularMoviesScreen: ViewCode{
    
    func setupViewHierarchy() {
        self.addSubview(activityIndicator)
        self.addSubview(collectionView)
        self.addSubview(emptySearchView)
    }
    
    func setupConstraints() {
        emptySearchView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        emptySearchView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        emptySearchView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        emptySearchView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        activityIndicator.style = .whiteLarge
        activityIndicator.color = Palette.blue
        collectionView.backgroundColor = Palette.white
    }
    
    
}
