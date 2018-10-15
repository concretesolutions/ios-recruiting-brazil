//
//  MoviesViewController.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class MoviesViewController: BaseViewController {

    //MARK: - Outlets
    
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //MARK: - Variables
    
    private var movies = [Movie]()
    
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
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.setCollectionViewLayout(ColumnFlowLayout(), animated: false)
        getMovies()
    }
    
    //MARK: - Methods
    
    @objc private func reloadData(){
        collectionView.reloadData()
    }
    
    @objc private func getMovies(){
        activityIndicatorView.startAnimating()
        MovieService.getPopularMovies { [unowned self](movies, error) in
            self.activityIndicatorView.stopAnimating()
            if let error = error{
                self.showMessage("Ops... Algo deu errado", mensagem: error.localizedDescription, completion: nil)
            }
            else{
                self.movies = movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

//MARK: - CollectionView DataSource, Delegate, DelegateFlowLayout

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: movies[indexPath.item], withDelegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showDetail(of: self.movies[indexPath.item])
    }
}

//MARK: - MovieCollectionViewCellDelegate
extension MoviesViewController: FavoriteMovieDelegate{
    func didAddedToFavorite(movie: Movie) {
        FavoriteController.shared.add(favorite: movie)
    }
    func didRemovedFromFavorite(movie: Movie) {
        FavoriteController.shared.remove(favorite: movie)
    }
}
