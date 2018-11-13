//
//  MoviesCollectionViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {

    
    
    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    var movies: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
      self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorOutlet.isHidden = false
        self.activityIndicatorOutlet.startAnimating()
        
        MovieDAO.getAll { (response, error) in
            if error != nil{
                return
            }//>>>>
            if let responseObj = response as? Response{
                
                let movies = responseObj.results
                   
                for movie in movies{
                    if let tempMovie = movie as? Movie{
                        self.movies.append(tempMovie)
                        print(tempMovie)
                    }
                }
                
            }
            self.activityIndicatorOutlet.stopAnimating()
            self.activityIndicatorOutlet.isHidden = true
            self.collectionView.reloadData()
        }//>>>>>
    
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviePreviewCell", for: indexPath) as? MoviePreviewCollectionViewCell
    
        cell?.setupCell(image: UIImage(named: "theMegPoster")!, title: self.movies[indexPath.row].title)
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(self.movies[indexPath.row].title)
        
        if let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "selectedMovieViewController") as? SelectedMovieTableViewController {
            
            viewController.movie = self.movies[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }


}
