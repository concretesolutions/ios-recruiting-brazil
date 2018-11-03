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

    var isLoadingCellCount = 0
    var canApplyFilter = true {
        didSet {
            if self.canApplyFilter == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.canApplyFilter = true
                }
            }
        }
    }
    
    //MARK: - Outlets
    @IBOutlet var gridCollectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridCollectionViewSetup()
        
//        self.manager.fetchMovies()
        
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController?.searchBar.delegate = self
        
        self.enableDismissKeyboard()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDescriptionSegue" {
            if let movieDescriptionInterface = segue.destination as? MovieDescriptionInterface {
                if let index = sender as? Int {
                    movieDescriptionInterface.set(movie: self.manager.movieFor(index: index))
                }
            }
        }
    }
    @IBAction func reloadAction(_ sender: Any) {
        self.manager.fetchMovies()
    }
}

extension HomeInterface: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationItem.searchController?.isActive = false
        self.performSegue(withIdentifier: "movieDescriptionSegue", sender: indexPath.row)
    }
}

extension HomeInterface: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.manager.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        
        let movie = self.manager.movieFor(index: indexPath.row)
        
        cell?.cardContentView.set(movie: movie)
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        cell?.layer.cornerRadius = 15
        cell?.layer.masksToBounds = true
        cell?.clipsToBounds = false
        
        cell?.layer.applySketchShadow(color: .black, alpha: 0.6, x: 0, y: 0, blur: 6, spread: 0)
        
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
        switch state {
        case .error:
            self.errorView.isHidden = false
        case .normal, .loading:
            self.errorView.isHidden = true
        }
    }
    
    func reload(_ indexPath: [IndexPath]) {
        self.gridCollectionView.reloadItems(at: visibleIndexPathsToReload(interesecting: indexPath))
    }
    
    func reload() {
        self.gridCollectionView.reloadData()
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
            self.manager.isFetchInProgress = false
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

extension HomeInterface: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.canApplyFilter {
            self.canApplyFilter = false
            self.manager.applyFilter(text: searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.searchBar.text = self.manager.filterText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.searchBar.text = self.manager.filterText
    }
}
