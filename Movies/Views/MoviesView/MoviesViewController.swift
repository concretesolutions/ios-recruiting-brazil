//
//  MoviesViewController.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/9/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class MoviesViewController: UICollectionViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var model: MoviesViewModel?
//    var moviesArray = [MovieModel]()
//    let r = RequestMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = MoviesViewModel(viewController: self)
        
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true;
        
//        r.delegate = self
//        r.requestPopular(pageToRequest: 1)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedCell = sender as! MoviesCollectionViewCell
        let selectedCellIndexPath = self.collectionView.indexPath(for: selectedCell)
        let selectedMovie = model!.moviesArray[selectedCellIndexPath!.row]
        
        let destinationViewController = segue.destination as! DetailsViewController
        destinationViewController.selectedMovie = selectedMovie
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model?.moviesArray.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MoviesCollectionViewCell else {
            fatalError("Not a category cell")
        }
        let movieToSetup = model?.moviesArray[indexPath.row]
        
        if (!movieToSetup!.isThumbnailLoaded){
            model?.loadImage(forMovie: movieToSetup!, completion: { (newThumbnail) in
                movieToSetup?.thumbnail = newThumbnail
                movieToSetup?.isThumbnailLoaded = true
                cell.movieThumbnailImageView.image = newThumbnail
                cell.setupForMovie(Movie: movieToSetup!)
            })
        }
        
        cell.setupForMovie(Movie: movieToSetup!)
    
        return cell
    }

    func didLoadPopularMovies() {
        self.collectionView.reloadData()
        self.loadingIndicator.stopAnimating()
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
