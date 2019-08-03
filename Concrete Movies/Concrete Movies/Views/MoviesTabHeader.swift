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
        movies.forEach { (movie) in
            vc?.movieDict[String(newIndex)] = movie
            newIndex += 1
        }
        vc?.moviesTabCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MoviesTabHeader: MovieSearchBarDelegate {
    func sendMovieToSearchBar(_ movies: [Movie]) {
        self.movies = movies
    }
}
