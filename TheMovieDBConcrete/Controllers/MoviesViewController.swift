//
//  MoviesViewController.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    var allMovies: Movies = Movies()
    // MARK: - Outlets
    @IBOutlet weak var movieFilterSearchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieDBAPIRequest.requestPopularMovies(withPage: 1) { (movies, error) in
            self.allMovies = movies
            self.moviesCollectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allMovies.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell
        cell.backgroundImage.image = allMovies.movies[indexPath.row].backgroundImage
        cell.nameLabel.text = allMovies.movies[indexPath.row].name
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
