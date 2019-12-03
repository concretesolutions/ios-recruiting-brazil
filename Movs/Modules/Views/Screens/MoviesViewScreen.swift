//
//  MoviesViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

final class MoviesViewScreen: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var moviesCollection: MoviesCollectionView = {
        let moviesCollection = MoviesCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        moviesCollection.delegate = moviesCollection
        moviesCollection.dataSource = self
        moviesCollection.register(MovieHomeCollectionViewCell.self, forCellWithReuseIdentifier: "movies")
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movies", for: indexPath) as? MovieHomeCollectionViewCell else {
            fatalError()
        }
        
        cell.coverImage.image = UIImage(named: "placeholder")
        return cell
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
