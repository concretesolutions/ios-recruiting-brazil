//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: BaseViewController {
    
    /// The list of favorited movies
    private var movies:[Movie] = []

    private unowned var favoriteMoviesView: FavoriteMoviesView{ return self.view as! FavoriteMoviesView }
    private unowned var collectionView:UICollectionView { return favoriteMoviesView.collectionView }
    
    override func loadView() {
        self.view = FavoriteMoviesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        setFilterButton()
        setupBarsTableView()
    }
    
    /// Adds the filter button to the Controller
    private func setFilterButton(){
        let filter = UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(openFilterController))
        self.navigationItem.rightBarButtonItem = filter
    }
    
    /// Sets up the collectionView
    private func setupBarsTableView(){
        collectionView.delegate        = self
        collectionView.dataSource      = self
    }
    
    /// Opens the FilterController
    @objc private func openFilterController(){
        self.present(FilterViewController(), animated: true, completion: nil)
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else{
            return UICollectionViewCell()
        }
        
        cell.setupCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController   = DetailMovieViewController()
        detailController.movie = movies[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.1, height: 70)
    }
}
