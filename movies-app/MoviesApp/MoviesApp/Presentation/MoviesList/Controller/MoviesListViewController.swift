//
//  ViewController.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 30/05/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    private let numberOfSections = 1
    private static let heightOfCell: CGFloat = 250
    private static let spaceBetweenCell: CGFloat = 4
    
    private lazy var requester = MoviesListRequester()
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDelegateAndDataSource()
        setColorForNavigationItem()
        getPopularMovies()
    }
    
    func getPopularMovies() {
        requester.getPopularMoviesList(path: APIData.mountPathForRequest(), responseRequest: { moviesList in
            if let movies = moviesList.movies {
                self.movies = movies
                self.collectionViewMovies.reloadData()
            } else {
                self.present(ErrorViewController(), animated: true, completion: nil)
            }
        })
    }
}

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionViewDelegateAndDataSource() {
        self.collectionViewMovies.delegate = self
        self.collectionViewMovies.dataSource = self
        self.collectionViewMovies.register(MoviesListCollectionViewCell.instanceOfNib(), forCellWithReuseIdentifier: MoviesListCollectionViewCell.reusableIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionViewCell.reusableIdentifier, for: indexPath) as? MoviesListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(for: movies[indexPath.row])
        cell.setCurrentMovie(movie: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionViewMovies.bounds.width / 2) - MoviesListViewController.spaceBetweenCell
        let height = MoviesListViewController.heightOfCell
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MoviesListViewController.spaceBetweenCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieDetailsViewController = MovieDetailsViewController(movie: movie)
        
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
