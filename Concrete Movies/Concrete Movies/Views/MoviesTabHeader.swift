//
//  MoviesTabHeader.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import UIKit

class MoviesTabHeader: UICollectionReusableView {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var headerView: UIView!
    
    var movies: [Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieSearchBar.delegate = self
    }
}

extension MoviesTabHeader: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let movies = self.movies.filter { $0.name.hasPrefix(searchText) }
        let vc = self.window?.rootViewController?.children[0] as? MoviesTabViewController
        vc?.movieDict.removeAll()
        var newIndex = 0
        var indexes: [Int] = []
        movies.forEach { (movie) in
            vc?.movieDict[String(newIndex)] = movie
            newIndex += 1
            indexes.append(vc?.indexes[movie.id] ?? 0)
        }
        if (movies.first == nil) {
            let movie = Movie()
            movie.image = UIImage(named: "search_icon")?.pngData()
            movie.name = "Please try again"
            vc?.movieDict["0"] = movie
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let vc = self.window?.rootViewController?.children[0] as? MoviesTabViewController
        vc?.moviesTabCollectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}

extension MoviesTabHeader: MovieSearchBarDelegate {
    func sendMovieToSearchBar(_ movies: [Movie]) {
        self.movies = movies
    }
}
