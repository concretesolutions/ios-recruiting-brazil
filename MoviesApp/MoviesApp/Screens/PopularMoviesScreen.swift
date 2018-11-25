//
//  PopularMoviesScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import SnapKit

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
        emptySearchView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        activityIndicator.style = .whiteLarge
        activityIndicator.color = Palette.blue
        collectionView.backgroundColor = Palette.white
    }
    
    
}
