//
//  ViewController.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 30/05/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var searchBarMovies: UISearchBar!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    private let numberOfSections = 1
    private var movies: [Movie] = []
    private static let heightOfCell: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDelegateAndDataSource()
    }
}

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionViewDelegateAndDataSource() {
        self.collectionViewMovies.delegate = self
        self.collectionViewMovies.dataSource = self
        self.collectionViewMovies.register(MoviesListCollectionViewCell.instanceOfNib(), forCellWithReuseIdentifier: MoviesListCollectionViewCell.reusableIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movies.count
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionViewCell.reusableIdentifier, for: indexPath) as? MoviesListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.labelTitle.text = "teste"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionViewMovies.bounds.width / 2) - 8
        let height = MoviesListViewController.heightOfCell
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
