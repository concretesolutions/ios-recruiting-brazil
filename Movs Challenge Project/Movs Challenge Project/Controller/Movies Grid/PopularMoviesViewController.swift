//
//  PopularMoviesViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 13/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private var popularMoviesView: PopularMoviesView {
        return self.view as! PopularMoviesView
    }
    
    // Private Methods
    
    private func initController() {
        self.view = PopularMoviesView()
        
        popularMoviesView.collectionView.dataSource = self
        popularMoviesView.collectionView.delegate = self
        popularMoviesView.collectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier)
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (popularMoviesView.bounds.width / 2.0) - (49.0 / 2.0)
        return CGSize(width: side, height: side * (3.0/2.0))
    }
}
