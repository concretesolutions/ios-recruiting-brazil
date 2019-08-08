//
//  MovieListViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToMovieListPresenterProtocol?
    var cellIdentifier:String = "cellItem"
    private var movies:[MovieListData]?
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.setModule(self)
        self.collectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        
        self.showActivityIndicator()
        self.presenter?.loadMovies()
    }
    
}

extension MovieListViewController : PresenterToMovieListViewProtocol {
    func returnMoviesError(message: String) {
        self.hideActivityIndicator()
    }
    
    func returnMovies(movies: [MovieListData]) {
        self.hideActivityIndicator()
        self.movies = movies
        DispatchQueue.main.async {
            
            if (self.movies?.count)! > 0 {
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
            }
            
            
        }
    }
}

extension MovieListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.movies?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieListCollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let movie:MovieListData = self.movies![indexPath.row]
        
        cell.fill(title: movie.name, urlPhotoImage: "\(Constants.imdbBaseUrl)\(movie.imageUrl)")
        
        return cell
    }
}

