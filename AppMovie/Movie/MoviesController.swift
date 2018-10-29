//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit


class MoviesController: UIViewController{

    var movies = [Movie]()
    var moviesFavorites = [Movie]()
    let dataSource = MoviesCollectionViewDataSource()
    var dadController : UIViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    //MARK: Privates Methods
    private func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        dataSource.datas = movies
        dataSource.controller = self
    }
}

//MARK: - Delegates
extension MoviesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let sb = UIStoryboard(name: "DescriptionMovie", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "description")
        if let _vc = vc as? DescriptionMovieViewController {
            _vc.movie = movies[indexPath.row]
            self.navigationController?.present(_vc, animated: true, completion: nil)
        }
    }
}

extension MoviesController: FavoriteMovieDelegate {
    func setFavorite(movie: Movie) {
        self.moviesFavorites.append(movie)
    }
    
    func removeFavorite(movie: Movie) {
        let index = getIndexFavorite(movie: movie)
        if  index != -1 {
            self.moviesFavorites.remove(at: index)
        }
    }
    
    private func getIndexFavorite(movie: Movie) -> Int {
        for (index, _movie) in moviesFavorites.enumerated() {
            let _id = _movie.movie?.id
            let id = movie.movie?.id
            if  _id == id {
                return index
            }
        }
        return -1
    }
}

extension MoviesController: SendDataDelegate {
    func send(data: Any) {
        if let _movies = data as? [Movie] {
            self.movies = _movies
            self.dataSource.datas = _movies
            if let dadController = self.dadController{
                self.dataSource.controller = dadController
            }
            self.collectionView.reloadData()
        }
    }
}
