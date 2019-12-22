//
//  MoviesViewController.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let screen = MovieView()
    var movies: [Results] = []
    var filteredData: [Results] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        self.view = screen
        self.view.backgroundColor = UIColor(named: "whiteCustom")
        self.screen.collectionView.delegate = self
        self.screen.collectionView.dataSource = self
        self.screen.collectionView.backgroundColor = .white
        //navigation
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "1dblackCustom")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "whiteCustom")!]
        self.navigationController?.navigationBar.isTranslucent = false
        seedMovies()
        FavoritesViewController.favTabDelegate = self
        //setting searchbar
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
        searchController.searchBar.searchTextField.tintColor = UIColor(named: "whiteCustom")
        searchController.searchBar.searchTextField.textColor = UIColor(named: "whiteCustom")
        searchController.delegate = self
        searchController.searchBar.delegate = self
         
    }
    
    func seedMovies(){
        let movieModel = MovieModel()
        screen.activityIndicator.startAnimating()
        movieModel.getAll{(result) in
            
            switch result{
            case .success(let movieResult):
                DispatchQueue.main.async {
                    self.screen.activityIndicator.stopAnimating()
                    for item in movieResult.results{
                        self.movies.append(item)
                    }
                    self.filteredData = self.movies
                    self.screen.collectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.screen.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        if FavoriteHelper.isFavorited(self.filteredData[indexPath.item].id){
            cell.favoriteButton.isHidden = false
        }else{
            cell.favoriteButton.isHidden = true
        }
        
        cell.movieTitle.text = self.filteredData[indexPath.item].originalTitle
        cell.activityIndicatorToImage.startAnimating()
        guard let imageUrl = URL(string: "\(EndPoints.baseImageUrl.rawValue)\(self.filteredData[indexPath.item].posterPath)") else{return cell}
        DispatchQueue.main.async {
            cell.movieImageView.load(url: imageUrl){(e) in
                cell.activityIndicatorToImage.stopAnimating()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        return CGSize(width: width/2.14, height: width/1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = DetailsViewController()
        detailsController.movieID = self.filteredData[indexPath.item].id
        detailsController.favIconDelegate = self
        detailsController.cellNumber = indexPath.item
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension MoviesViewController: FavDelegate{
    func putFavIcon(equal: Bool, forCell: Int) {
        if equal{
            let cell = screen.collectionView.cellForItem(at: NSIndexPath(item: forCell, section: 0) as IndexPath) as! MovieCollectionViewCell
            cell.favoriteButton.isHidden = false
        }else{
            let cell = screen.collectionView.cellForItem(at: NSIndexPath(item: forCell, section: 0) as IndexPath) as! MovieCollectionViewCell
            cell.favoriteButton.isHidden = true
        }
    }
    
    
}

extension MoviesViewController: FavTabDelegate{
    func unFavMovie(movId: Int) {
        var count = 0
        for mov in self.filteredData{
            if mov.id == movId{
                if let targetCell = self.screen.collectionView.cellForItem(at: NSIndexPath(item: count, section: 0) as IndexPath) as? MovieCollectionViewCell {
                
                    targetCell.favoriteButton.isHidden = true
                }
                
            }
            count += 1
        }
    }
}

extension MoviesViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {return}
        
        if searchBarText.isEmpty || searchBarText.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            filteredData = movies
            self.screen.collectionView.isHidden = false
            self.screen.noResultsImageView.isHidden = true
            self.screen.noResultsLabel.isHidden = true
        }else{
            filteredData = movies.filter{(data)->Bool in
                self.screen.collectionView.isHidden = false
                self.screen.noResultsImageView.isHidden = true
                self.screen.noResultsLabel.isHidden = true
                return data.originalTitle.range(of: searchBarText, options: [ .caseInsensitive ]) != nil
            }
            if filteredData.count == 0{
                self.screen.collectionView.isHidden = true
                self.screen.noResultsImageView.isHidden = false
                self.screen.noResultsLabel.isHidden = false
                self.screen.noResultsLabel.text = "No results for \"\(searchBarText)\" "
            }
        }
        self.screen.collectionView.reloadData()
    }
    
    
}
