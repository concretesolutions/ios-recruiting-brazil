//
//  PopularMoviesViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

final class PopularMoviesViewScreen: UIView {
    
    // MARK: - Interface elements
    
    lazy var moviesCollectionView: UICollectionView = {
        let moviesCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        moviesCollection.backgroundColor = UIColor.clear
        moviesCollection.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: "movies")
        return moviesCollection
    }()
    
    lazy var loadingIndicatorView: TranslucidActivityIndicatorView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterial)
        let indicatorView = TranslucidActivityIndicatorView(effect: blur)
        indicatorView.layer.cornerRadius = 8.0
        indicatorView.layer.masksToBounds = true
        return indicatorView
    }()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        super.init(frame: .zero)
        self.setupView()
        self.loadingIndicatorView.alpha = 0
        self.loadingIndicatorView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopularMoviesViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.moviesCollectionView)
        self.addSubview(self.loadingIndicatorView)
    }
    
    func setupConstraints() {        
        self.moviesCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self)
        }
        
        self.loadingIndicatorView.snp.makeConstraints({ make in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.2)
            make.height.equalTo(self.loadingIndicatorView.snp.width)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.systemBackground
    }
}
