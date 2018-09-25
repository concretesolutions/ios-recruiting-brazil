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
        MovieDBAPIRequest.getAllRenres { (genres, error) in
            AllGenresSingleton.allGenres = genres
        }
        
//        self.movieFilterSearchBar.layer.zPosition = 1000
//        self.movieFilterSearchBar.layer.cornerRadius = 20
//        self.movieFilterSearchBar.clipsToBounds = false
//        self.movieFilterSearchBar.layer.shadowColor = UIColor.black.cgColor
//        self.movieFilterSearchBar.layer.shadowOpacity = 0.5
//        self.movieFilterSearchBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.movieFilterSearchBar.layer.shadowRadius = 3
        if let txfSearchField = movieFilterSearchBar.value(forKey: "_searchField") as? UITextField {
            txfSearchField.layer.cornerRadius = 10
            txfSearchField.borderStyle = .none
            txfSearchField.backgroundColor = .white
            txfSearchField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 20))
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(searchActive) {
            if filteredMovies.movies.isEmpty {
                let backgroundViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ErrorSearchID") as! SearchErrorViewController
                print(movieFilterSearchBar.text)
                let myView = backgroundViewController.view as! ErrorView
                myView.errorText.text = "Sua busca por " + movieFilterSearchBar.text! + " não resulto em nenhum resultado"
                self.moviesCollectionView.backgroundView = myView
                self.moviesCollectionView.backgroundView?.isHidden = false
            }
            return filteredMovies.movies.count
        }
        
        if allMovies.movies.isEmpty {
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
        } else {
            cell.backgroundImage.image = allMovies.movies[indexPath.row].backgroundImage
            cell.nameLabel.text = allMovies.movies[indexPath.row].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewControllerId") as? MovieViewController {
            vc.movie = self.allMovies.movies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
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
        searchActive = true
        print("111111")
        self.moviesCollectionView.reloadData()
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
