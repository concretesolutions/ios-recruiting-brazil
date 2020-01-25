//
//  ViewController.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let moviesViewModel = MoviesViewModel()
    var movieSelected: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        moviesViewModel.delegate = self
        loadMovies()
        view.activityStartAnimating()
        
    }
    
    func loadMovies() {
        moviesViewModel.requestMovies(completionHandler: { reload in
            self.collectionView.reloadData()
            self.view.activityStopAnimating()
            
        })
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewModel.arrayMovies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = MovieCollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell.identiifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.movie = moviesViewModel.getMovie(indexPath: indexPath)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        moviesViewModel.loadMoreMovies(indexPath: indexPath, completionHandler: {
            reload in
            self.collectionView.reloadData()
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovieDetailViewController" {
            if let detailViewController = segue.destination as? MovieDetailsViewController {
                detailViewController.id = movieSelected?.id
            }
        }
    } 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = moviesViewModel.arrayMovies[indexPath.row]
        movieSelected = movie
        performSegue(withIdentifier: "segueMovieDetailViewController", sender: self)
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = (view.frame.size.width - 45) / 2
        return CGSize(width: screenWidth, height: screenWidth * (4.8/3))
    }
}

