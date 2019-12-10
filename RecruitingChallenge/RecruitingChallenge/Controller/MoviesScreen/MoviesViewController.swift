//
//  MoviesViewController.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/8/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire


class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieManager = MovieManager()
    var moviesFromApi: [MoviesModel] = []
    var filteredMovies: [MoviesModel] = []
    let identifier = "moviesCell"
    private let spacing:CGFloat = 16.0
    var isSearching: Bool = false
    var indexMoviesCollection: IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
         movieManager.showMostPopularMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.tintColor = UIColor.black
        
        movieManager.delegate = self
        setupCollectionView()
        setupSearchBar()
        
    }
    
    func setupSearchBar() {
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Movies "
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
    }
    
    func setupCollectionView () {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "MoviesCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredMovies = moviesFromApi
        searchBar.showsCancelButton = true
        if searchText.isEmpty == false {
            filteredMovies = moviesFromApi.filter({ $0.movieTitle.localizedCaseInsensitiveContains(searchText)})
        } else {
            searchBar.resignFirstResponder()
        }
        
        collectionView.reloadData()
        return
    }
}


extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MoviesCell
        
        var posterImg: UIImage?
        
        Alamofire.request(filteredMovies[indexPath.item].posterImage).responseImage { (response) in
            if let movieImage = response.result.value {
                posterImg = movieImage
                DispatchQueue.main.async {
                    cell.movieImg.image = posterImg
                }
            }
            cell.movieName.text = self.filteredMovies[indexPath.item].movieTitle
        }
        
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 5
        
        let totalSpacing = (8 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        
        return CGSize(width: width + 40, height: width + 80)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let navigation = self.navigationController else { return }
        let detailMoviesVC = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
        
        indexMoviesCollection = indexPath
        detailMoviesVC.delegateMovies = self
        detailMoviesVC.detailCellArray = filteredMovies
        navigation.pushViewController(detailMoviesVC, animated: true)
        
    }
}

extension MoviesViewController: MovieManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateMovies(movies: [MoviesModel]) {
        moviesFromApi = movies
        filteredMovies = moviesFromApi
    }
}

extension MoviesViewController: PassDataDelegate {
    var moviesArray: [MoviesModel] {
        self.moviesFromApi
    }
    
    var getIndex: IndexPath {
        get {
            self.indexMoviesCollection!
        }
        
    }
}

