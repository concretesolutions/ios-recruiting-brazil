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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieSearchBar.delegate = self
        movieSearchBar.enablesReturnKeyAutomatically = true
    }
}

extension MoviesTabHeader: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
}
