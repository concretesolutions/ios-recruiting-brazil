//
//  HomeInterface.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

enum HomeInterfaceState {
    case normal
    case error
    case loading
}

class HomeInterface: UIViewController {
    
    lazy var manager = HomeManager(self)
    
    //MARK: - Status Bar Config
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    var isStatusBarHidden: Bool = false
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    //MARK: - Outlets
    @IBOutlet var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridCollectionViewSetup()
        
        self.manager.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.gridCollectionView.reloadItems(at: self.gridCollectionView.indexPathsForVisibleItems)
    }
    
    func gridCollectionViewSetup() {
        self.gridCollectionView.delegate = self
        self.gridCollectionView.dataSource = self
        self.gridCollectionView.prefetchDataSource = self
        
        self.gridCollectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
}

extension HomeInterface: UICollectionViewDelegate {
    
}

extension HomeInterface: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        
        if !isLoadingCell(for: indexPath) {
            if let model = self.manager.movieModelIn(index: indexPath.row) {
                cell?.set(model: model)
                cell?.indexPath = indexPath
                cell?.delegate = self
            }
        }
        
        
        return cell ?? UICollectionViewCell()
    }
}

extension HomeInterface: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.85 / 2, height: collectionView.frame.width * 0.85 / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * 0.049
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * 0.049
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let frame = collectionView.frame
        return UIEdgeInsets(top: frame.width * 0.05, left: frame.width * 0.05, bottom: frame.width * 0.05, right: frame.width * 0.05)
    }
}

extension HomeInterface: HomeInterfaceProtocol {
    func set(state: HomeInterfaceState) {
        
    }
    
    func reload(_ indexPath: [IndexPath]) {
        if indexPath.count > 0 {
            self.gridCollectionView.reloadItems(at: visibleIndexPathsToReload(interesecting: indexPath))
        } else {
           self.gridCollectionView.reloadData()
        }
    }
}


extension HomeInterface: MovieCellDelegate {
    func saveTapped(indexPath: IndexPath) {
        self.manager.handleMovie(indexPath: indexPath)
    }
}


extension HomeInterface: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.manager.fetchMovies()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.manager.movies.count
    }
    
    func visibleIndexPathsToReload(interesecting indexPaths: [IndexPath] ) -> [IndexPath] {
        let indexPathsForVisibleItems = self.gridCollectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
