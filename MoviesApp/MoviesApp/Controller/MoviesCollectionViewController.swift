//
//  MoviesCollectionViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit
import Kingfisher


private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    var movies: [Movie] = []
    
    var filteredMovies = [Movie]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        
      self.tabBarController?.tabBar.isHidden = false
        
        //self.activityIndicatorOutlet.isHidden = false
        //self.activityIndicatorOutlet.startAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies..."
        
        MovieDAO.getAll { (response, error) in
            if error != nil{
                return
            }//>>>>
            if let responseObj = response as? Response{
                
                let movies = responseObj.results
                
                for movie in movies{
                    if let tempMovie = movie as? Movie{
                        print("xablau2")
                        self.movies.append(tempMovie)
                        print(tempMovie)
                    }
                }
                
            }
            self.activityIndicatorOutlet.stopAnimating()
            self.activityIndicatorOutlet.isHidden = true
            self.collectionView.reloadData()
        }//>>>>>
        
        self.navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if isFiltering() {
            return filteredMovies.count
        }
        
        return movies.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviePreviewCell", for: indexPath) as? MoviePreviewCollectionViewCell
    
    
        print(self.movies.count)
        
        if isFiltering() {
            cell?.setupCell(image: UIImage(named: "theMegPoster")!, title: self.filteredMovies[indexPath.row].title, movie: self.filteredMovies[indexPath.row])
        }else{
            cell?.setupCell(image: UIImage(named: "theMegPoster")!, title: self.movies[indexPath.row].title, movie: self.movies[indexPath.row])
        }
        
       
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(self.movies[indexPath.row].title)
        
        if let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "selectedMovieViewController") as? SelectedMovieTableViewController {
            
            if isFiltering(){
                viewController.movie = self.filteredMovies[indexPath.row]
            }else{
                viewController.movie = self.movies[indexPath.row]
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.movies.count/4*3 {
            print(indexPath.row)
            
            var InitPage = Int(NetworkManager.shared.initialPage)!
            print("#############")
            print(InitPage)
            var newPage = InitPage + 1
            print(newPage)
            NetworkManager.shared.initialPage = String(newPage)
            print(NetworkManager.shared.initialPage)
            
            MovieDAO.getAll { (response, error) in
                if error == nil{
                    if let responseObj = response as? Response{

                        let movies = responseObj.results
                        print(NetworkManager.shared.initialPage)

                        for movie in movies{
                            if let tempMovie = movie as? Movie{
                                print(NetworkManager.shared.initialPage)
                                print("xablau3")
                                self.movies.append(tempMovie)
                                print(tempMovie)
                            }
                        }

                        self.collectionView.reloadData()

                    }
                }else{
                    print("Couldn't update page")

                }
            }
            
        }
        
    }


}

extension MoviesCollectionViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}
