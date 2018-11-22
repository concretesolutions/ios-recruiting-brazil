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
    
    var hasLoadedData = false
    
    var searchedMovies = [Movie]()
    
    var canFilter: Bool = false
    
    var searchImageView = UIImageView()
    var searchLabel = UILabel()
    var hasAddedSearchImage: Bool = false
    var searchText = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if hasLoadedData == false {
            
            self.activityIndicatorOutlet.isHidden = false
            self.activityIndicatorOutlet.startAnimating()
            
            MovieDAO.getAll { (response, error) in
                if error != nil{
                    print("Erro ao retornar os dados da API")
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
                self.canFilter = true
                self.hasLoadedData = true
            }//>>>>>
        }
        
      self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies..."
        
        
        if hasLoadedData == false {
            
            self.activityIndicatorOutlet.isHidden = false
            self.activityIndicatorOutlet.startAnimating()
            
            MovieDAO.getAll { (response, error) in
                if error != nil{

                    let errorText = "Um erro inesperado aconteceu. Tente novamente"
                    let errorLabel = UILabel()
                    errorLabel.center.x = self.collectionView.center.x
                    errorLabel.center.y = self.collectionView.center.y
                    errorLabel.frame.size = CGSize(width: 300, height: 150)
                    errorLabel.textAlignment = .center
                    errorLabel.text = errorText
                    self.collectionView.addSubview(errorLabel)
                    
                    
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
                self.canFilter = true
                self.hasLoadedData = true
            }//>>>>>
        }
        
        
        self.navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if isFiltering() {
            return searchedMovies.count
        }
        
        return movies.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviePreviewCell", for: indexPath) as? MoviePreviewCollectionViewCell
    
    
        print(self.movies.count)
        
        if isFiltering() {
            cell?.setupCell(title: self.searchedMovies[indexPath.row].title, movie: self.searchedMovies[indexPath.row])
        }else{
            cell?.setupCell(title: self.movies[indexPath.row].title, movie: self.movies[indexPath.row])
        }
        
       
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(self.movies[indexPath.row].title)
        
        if let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "selectedMovieViewController") as? SelectedMovieTableViewController {
            
            if isFiltering(){
                viewController.movie = self.searchedMovies[indexPath.row]
                
            }else{
                viewController.movie = self.movies[indexPath.row]
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.movies.count-1 {
            print(indexPath.row)
            
            let InitPage = Int(NetworkManager.shared.initialPage)!
            print("#############")
            print(InitPage)
            let newPage = InitPage + 1
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

extension MoviesCollectionViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        searchedMovies = movies.filter({( movie : Movie) -> Bool in
            self.searchText = searchText
            print(self.searchText)
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    

    
    func isFiltering() -> Bool {
        
        print("Filtrando")
        
        if (self.searchedMovies.isEmpty == true && !searchBarIsEmpty()) && hasAddedSearchImage == false {
            print("Sua busca não retornou resultados")
            
            let searchText = "Sua busca por \"" + self.searchText + "\" não retornou resultados"
            self.searchLabel.text = searchText
            self.searchLabel.textAlignment = .center
            self.searchLabel.frame.size = CGSize(width: 300, height: 150)
            self.searchLabel.numberOfLines = 3
            self.searchLabel.center = self.collectionView.center
            
            let searchImage = UIImage(named: "search_icon.png")
            self.searchImageView = UIImageView(image: searchImage)
            self.searchImageView.frame.size = CGSize(width: 100, height: 100)
            self.searchImageView.center.x = self.collectionView.center.x
            self.searchImageView.center.y = self.collectionView.center.y - 100
            self.collectionView.addSubview(searchImageView)
            self.collectionView.addSubview(searchLabel)
            hasAddedSearchImage = true
            
        }
        
        if (self.searchedMovies.isEmpty == false && !searchBarIsEmpty()) && hasAddedSearchImage == true {
            self.searchImageView.removeFromSuperview()
            self.hasAddedSearchImage = false
            self.searchLabel.removeFromSuperview()
        }
        
        
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("Dismiss")
        
        if self.hasAddedSearchImage == true {
            self.searchImageView.removeFromSuperview()
            self.searchLabel.removeFromSuperview()
        }
        
    }
    

    
}
