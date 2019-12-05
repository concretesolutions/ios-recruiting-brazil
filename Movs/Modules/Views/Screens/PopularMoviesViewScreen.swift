//
//  PopularMoviesViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

final class PopularMoviesViewScreen: UIView {
    
    // MARK: - Interface elements
    
    lazy var moviesCollectionView: UICollectionView = {
        let moviesCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        moviesCollection.backgroundColor = UIColor.clear
        moviesCollection.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: "movies")
        return moviesCollection
    }()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopularMoviesViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.moviesCollectionView)
    }
    
    func setupConstraints() {        
        self.moviesCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.systemBackground
    }
}
