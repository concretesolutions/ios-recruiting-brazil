//
//  MoviesTabViewController.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit

class MoviesTabViewController: ViewController {
    @IBOutlet weak var movieTabBarItem: UITabBarItem!
    @IBOutlet weak var moviesTabCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        collectionViewInitialSetup()
        collectionViewSetLayout()
    }
}

//Handles CollectionView
extension MoviesTabViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewInitialSetup() {
        moviesTabCollectionView.delegate = self
        moviesTabCollectionView.dataSource = self
        moviesTabCollectionView.reloadData()
    }
    
    func collectionViewSetLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        layout.itemSize = CGSize(width: 200, height: 200)
        moviesTabCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 186, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "MoviesTabCollection", bundle: Bundle(for: MoviesTabCollection.self)), forCellWithReuseIdentifier: "MoviesTabCollection")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesTabCollection", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            collectionView.register(UINib(nibName: "MoviesTabHeader", bundle: Bundle(for: MoviesTabHeader.self)), forSupplementaryViewOfKind: kind, withReuseIdentifier: "MoviesTabHeader")
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MoviesTabHeader", for: indexPath)
            return header
        } else {
            assert(false)
        }
    }
}
