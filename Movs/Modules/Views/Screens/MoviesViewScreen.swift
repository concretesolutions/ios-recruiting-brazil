//
//  MoviesViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

final class MoviesViewScreen: UIView {
    
    // MARK: - Interface elements
    
    lazy var moviesCollection: MoviesCollectionView = {
        let moviesCollection = MoviesCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        moviesCollection.register(MovieHomeCollectionViewCell.self, forCellWithReuseIdentifier: "movies")
        return moviesCollection
    }()
    
    // MARK: -
    
    weak var collectionDelegate: MoviesViewController? {
        didSet {
            guard let delegate = self.collectionDelegate else { return }
            self.moviesCollection.delegate = delegate
            self.moviesCollection.dataSource = delegate
            self.moviesCollection.prefetchDataSource = delegate
        }
    }
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviesViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.moviesCollection)
    }
    
    func setupConstraints() {        
        self.moviesCollection.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.systemBackground
    }
}
