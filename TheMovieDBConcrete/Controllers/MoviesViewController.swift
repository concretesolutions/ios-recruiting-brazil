//
//  MoviesViewController.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    
    // MARK: - Variables
    var allMovies: Movies = Movies()
    var searchActive = false
    var filteredMovies: Movies = Movies()
    var requestHasError = false
    var page = 1
    
    // MARK: - Outlets
    @IBOutlet weak var movieFilterSearchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.makeRequests()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.moviesCollectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    // MARK: - SetUp
    func setUp() {
        let view = UIView.init(frame: moviesCollectionView.frame)
        print(moviesCollectionView.frame)
        print(view.frame)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 50, height: 50))
        print(loadingIndicator.frame)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        self.moviesCollectionView.backgroundView = view
        self.moviesCollectionView.backgroundView?.isHidden = false
    }
    
    // MARK: - Requests
    func makeRequests() {
        MovieDBAPIRequest.requestPopularMovies(withPage: page) { (movies, error) in
            if error {
                self.requestHasError = true
            } else {
                self.allMovies = movies
            }
            self.moviesCollectionView.reloadData()
        }
        MovieDBAPIRequest.getAllRenres { (genres, error) in
            AllGenresSingleton.allGenres = genres
        }
    }
    // MARK: - CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(searchActive) {
            if filteredMovies.movies.isEmpty {
                let backgroundViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ErrorSearchID") as! SearchErrorViewController
                let myView = backgroundViewController.view as! ErrorView
                myView.errorText.text = "Sua busca por " + movieFilterSearchBar.text! + " não resulto em nenhum resultado"
                self.moviesCollectionView.backgroundView = myView
                self.moviesCollectionView.backgroundView?.isHidden = false
            }
            return filteredMovies.movies.count
        } else if requestHasError {
            let backgroundViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ErrorID")
            self.moviesCollectionView.backgroundView = backgroundViewController.view
            self.moviesCollectionView.backgroundView?.isHidden = false
        } else {
            self.moviesCollectionView.backgroundView?.isHidden = true
        }
        
        return allMovies.movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell
        if searchActive {
            cell.backgroundImage.image = filteredMovies.movies[indexPath.row].backgroundImage
            cell.nameLabel.text = filteredMovies.movies[indexPath.row].name
            let isFavorite = PersistenceService.isFavorite(withTitle: filteredMovies.movies[indexPath.row].name)
            if isFavorite {
                cell.favoriteIcon.image = #imageLiteral(resourceName: "favorite_full_icon")
            } else {
                cell.favoriteIcon.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }
        } else {
            cell.backgroundImage.image = allMovies.movies[indexPath.row].backgroundImage
            cell.nameLabel.text = allMovies.movies[indexPath.row].name
            let isFavorite = PersistenceService.isFavorite(withTitle: allMovies.movies[indexPath.row].name)
            if isFavorite {
                cell.favoriteIcon.image = #imageLiteral(resourceName: "favorite_full_icon")
            } else {
                cell.favoriteIcon.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewControllerId") as? MovieViewController {
            vc.movie = self.allMovies.movies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !searchActive {
            if indexPath.row == self.allMovies.movies.count - 5 {
                self.page += 1
                MovieDBAPIRequest.requestPopularMovies(withPage: page) { (movies, error) in
                    for movie in movies.movies {
                        self.allMovies.movies.append(movie)
                        self.moviesCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - SEARCHBAR
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredMovies.movies = allMovies.movies.filter({ (text) -> Bool in
            let tmp: NSString = (text.name as NSString?)!
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if searchText == "" {
            searchActive = false
        } else {
            searchActive = true
        }
        print("111111")
        self.moviesCollectionView.reloadData()
    }
    
}
