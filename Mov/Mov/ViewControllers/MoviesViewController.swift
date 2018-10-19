//
//  MoviesViewController.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

final class MoviesViewController: BaseViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //MARK: - Variables
    
    private let kMinimumSpace: CGFloat = 10.0
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading: Bool = false
    private var isSearching: Bool = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(rawValue: "favoriteAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(rawValue: "favoriteRemoved"), object: nil)
    }
    
    override func setupInterface() {
        super.setupInterface()
        currentTitle = "Movies"
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell.identifier")
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        getMovies()
    }
    
    //MARK: - Methods
    
    @objc private func reloadData(){
        collectionView.reloadData()
    }
    
    @objc private func getMovies(){
        
        if currentPage > 1{
            collectionView.beginInfiniteScroll(true)
        }
        else{
            activityIndicatorView.startAnimating()
        }
        self.isLoading = true
        MovieService.getPopularMovies(with: currentPage) { [unowned self](movies, page, total, error)  in
            self.activityIndicatorView.stopAnimating()
            self.collectionView.finishInfiniteScroll()
            if let error = error{
                self.isLoading = false
                self.showMessage("Ops... Algo deu errado", mensagem: error.localizedDescription, completion: nil)
            }
            else{
                
                DispatchQueue.main.async {
                    if self.currentPage > 1{
                        self.collectionView.performBatchUpdates({
                            for movie in movies{
                                self.movies.append(movie)
                                self.filteredMovies.append(movie)
                                let indexPath = IndexPath(item: self.filteredMovies.count - 1, section: 1)
                                self.collectionView.insertItems(at: [indexPath])
                            }
                        }, completion: { (_) in
                            self.currentPage = page
                            self.totalPages = total
                            self.isLoading = false
                        })
                    }
                    else{
                        self.movies = movies
                        self.filteredMovies = movies
                        self.collectionView.reloadData()
                        self.currentPage = page
                        self.totalPages = total
                        self.isLoading = false
                    }
                }
            }
        }
    }
}

//MARK: - CollectionView DataSource, Delegate, DelegateFlowLayout

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let hasData = isSearching ? !self.filteredMovies.isEmpty : !self.movies.isEmpty
        let type = isSearching ? UICollectionView.EmptyListType.search : UICollectionView.EmptyListType.error
        collectionView.setEmpty(for: type, hasData: hasData)
        
        return section == 0 ? 1 : self.filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell.identifier", for: indexPath) as! SearchCollectionViewCell
            
            cell.searchBar.delegate = self
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: filteredMovies[indexPath.item], withDelegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            let itemWidth = collectionView.frame.width
            let itemHeight: CGFloat = 44.0
            return CGSize(width: itemWidth, height: itemHeight)
            
        case 1:
            
            let availableWidth: CGFloat = collectionView.bounds.inset(by: collectionView.layoutMargins).size.width
            let minColumnWidth: CGFloat = 168.0
            let maxColumns: Int = Int(availableWidth / minColumnWidth)
            let cellWidth = ((availableWidth - kMinimumSpace * CGFloat(maxColumns)) / CGFloat(maxColumns).rounded(.down))
            let itemSize = CGSize(width: cellWidth, height: 245.0)
            
            return itemSize
        default:
            assert(false)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showDetail(of: self.filteredMovies[indexPath.item])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        guard scrollView === self.collectionView else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell, cell.searchBar.isFirstResponder else { return }
        cell.searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard movies.isEmpty == false, isLoading == false, isSearching == false else { return }
        let actualPosition = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height - (self.collectionView.frame.size.height)
        if (actualPosition >= contentHeight) && currentPage < totalPages {
            self.currentPage += 1
            self.getMovies()
        }
    }
}

//MARK: - MovieCollectionViewCellDelegate
extension MoviesViewController: FavoriteMovieDelegate{
    func didAddedToFavorite(movie: Movie) {
        //Getting movie detail before add as favorite
        MovieService.getDetail(with: movie.id) { (movie, error) in
            if let movie = movie{
                FavoriteController.shared.add(favorite: movie)
            }
        }
    }
    func didRemovedFromFavorite(movie: Movie) {
        FavoriteController.shared.remove(favorite: movie)
    }
}

//MARK: - SearchBarDelegate
extension MoviesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let oldFilteredData = self.filteredMovies
        
        if searchText.isEmpty{
            self.filteredMovies = self.movies
            self.isSearching = false
        }
        else{
            self.isSearching = true
            self.filteredMovies = self.movies.filter({ (movie) -> Bool in
                movie.title.range(of: searchText) != nil
            })
        }
        
        self.collectionView.performBatchUpdates({
            for (oldIndex, oldMovie) in oldFilteredData.enumerated() {
                if self.filteredMovies.contains(oldMovie) == false{
                    let indexPath = IndexPath(item: oldIndex, section: 1)
                    self.collectionView.deleteItems(at: [indexPath])
                }
            }
            
            for (index, movie) in self.filteredMovies.enumerated() {
                if oldFilteredData.contains(movie) == false{
                    let indexPath = IndexPath(item: index, section: 1)
                    self.collectionView.insertItems(at: [indexPath])
                }
            }
            
        }, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
