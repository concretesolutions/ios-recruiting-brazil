//
//  ViewController.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 11/27/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieManager = MovieManager()
    var moviesFromApi: [MoviesModel] = []
    let identifier = "moviesCell"
    
    private let spacing:CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        setupSearchBar()
       
        
        let nib = UINib(nibName: "MoviesCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: identifier)
        
        movieManager.showMostPopularMovies()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
        
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            //             fetchCharacters(for: query)
            
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let movie = searchBar.text {
            movieManager.fetchMovie(movieName: movie)
        }
        
        searchBar.text = ""
        
    }
    
    //     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //           searchAirport = airportArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
    //           searching = true
    //           searchAirport.append(searchText)
    //           tableView.reloadData()
    //
    //       }
    //
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesFromApi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MoviesCell
        
        cell.movieName.text = moviesFromApi[indexPath.item].movieTitle
        
        var posterImg: UIImage?
        
        Alamofire.request(moviesFromApi[indexPath.item].posterImage).responseImage { (response) in
            if let movieImage = response.result.value {
                posterImg = movieImage
                
                DispatchQueue.main.async {
                    cell.movieImg.image = posterImg
                }
                
            }
        }
        
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 5
        
        let totalSpacing = (8 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width + 40, height: width + 80)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate {
    
}

extension MoviesViewController: MovieManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateMovies(movies: [MoviesModel]) {
        moviesFromApi = movies
    }
}
