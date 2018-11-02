//
//  FavoritesInterface.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

enum FavoritesInterfaceState {
    case normal
    case error
}

class FavoritesInterface: UIViewController {
    
    lazy var manager = FavoritesManager(self)
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listCollectionViewSetup()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.manager.load()
        self.listCollectionView.reloadData()
    }
    
    func setup() {
        self.searchBar.delegate = self
        self.enableDismissKeyboard()
    }
    
    func listCollectionViewSetup() {
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
    
        self.listCollectionView.register(UINib(nibName: FavoritedMovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavoritedMovieCell.identifier)
    }
}

extension FavoritesInterface: UICollectionViewDelegate {
    
}

extension FavoritesInterface: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritedMovieCell.identifier, for: indexPath) as? FavoritedMovieCell
        
        cell?.set(movie: self.manager.movieIn(index: indexPath.row))
        
        return cell ?? UICollectionViewCell()
    }
}

extension FavoritesInterface: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.899, height: collectionView.frame.width * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * 0.025
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * 0.025
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.frame.width
        return UIEdgeInsets(top: width * 0.025, left: width * 0.025, bottom: width * 0.025, right: width * 0.025)
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        self.manager.deleteMovieAt(index: indexPath.row)
        self.listCollectionView.deleteItems(at: [indexPath])
    }
}

extension FavoritesInterface: FavoritesInterfaceProtocol {
    func set(state: FavoritesInterfaceState) {
        
    }
    
    func reload() {
        self.listCollectionView.reloadData()
    }
}

extension FavoritesInterface: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.manager.filter(text: searchText)
    }
}
