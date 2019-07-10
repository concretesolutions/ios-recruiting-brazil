//
//  PopularMoviesViewController.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit
import SnapKit

class PopularMoviesViewController: UIViewController {
    
    var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var viewModel: PopularMoviesViewModel = PopularMoviesViewModel()
    
    var cellsViewModels: [MovieCollectionViewCellViewModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = .white
        self.viewModel.delegate = self
        self.viewModel.fetchMovies()
        self.setupNavigationAndSearchBar()
        self.setupCollectionView()
        
        
    }
    
    fileprivate func setupNavigationAndSearchBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = .yellow
        
        self.searchBar.placeholder = "Search"
        self.searchBar.delegate = self
        self.searchBar.frame = CGRect(x: 0, y: 0, width: (navigationController?.view.bounds.size.width)!, height: 64)
        self.searchBar.barStyle = .default
        self.searchBar.isTranslucent = false
        self.searchBar.barTintColor = .yellow
        view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
        }
        
    }

    
    fileprivate func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        let cellWidth = self.view.frame.width/2
        let cellHeight = cellWidth*1.1
        layout.itemSize = CGSize(width: cellWidth,
                                 height: cellHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.view.addSubview(self.collectionView)
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
        }
    }
 

}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellsViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.viewModel = self.cellsViewModels[indexPath.row]
        return cell
    }
   
    
}

extension PopularMoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterBySearch(searchText)
    }
}


extension PopularMoviesViewController: PopularMoviesDelegate {
    func updateCellsViewModels(_ cellsViewModels: [MovieCollectionViewCellViewModel]) {
        self.cellsViewModels = cellsViewModels
    }
   
}

