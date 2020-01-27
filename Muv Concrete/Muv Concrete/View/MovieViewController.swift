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
    @IBOutlet weak var searchBar: UISearchBar!
    
    let moviesViewModel = MoviesViewModel()
    var movieSelected: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchScreenHideKeyboard()
        
        self.collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        moviesViewModel.delegate = self
        searchBar.delegate = self
        loadMovies()
        
        searchBar.backgroundImage = UIImage()
        
    }
    
    func loadMovies() {
        view.activityStartAnimating()
        moviesViewModel.requestMovies(completionHandler: { reload in
            if reload {
                self.collectionView.reloadData()
            } else {
                self.collectionView.isHidden = true
                let updateButton = UIButton(frame: CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2, width: 50, height: 40))
                updateButton.backgroundColor = .green
                updateButton.setTitle("Update", for: [])
                updateButton.addTarget(self, action: #selector(self.update), for: .touchUpInside)

                self.view.addSubview(updateButton)
            }
            self.view.activityStopAnimating()
        })
    }
    
    @objc func update(sender: UIButton!) {
      loadMovies()
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

extension MovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        moviesViewModel.search(searchText: searchText, completionHandler: { result in
            if result {
                self.collectionView.reloadData()
            }
        })
    }
}
