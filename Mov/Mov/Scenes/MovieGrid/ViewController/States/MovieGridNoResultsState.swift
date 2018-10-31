//
//  MovieGridNoResultsState.swift
//  Mov
//
//  Created by Miguel Nery on 30/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class MovieGridNoResultsState: MovieGridBaseState {
    
    var searchRequest = ""
    
    override func hideViews() -> [UIView] {
        
        return [movieGrid.collection, movieGrid.networkErrorView]
    }
    
    override func showViews() -> [UIView] {
        return [movieGrid.noResultsView, movieGrid.searchBar]
    }
    
    override func onEnter() {
        movieGrid.noResultsView.errorLabel.text = Texts.noResults(for: self.searchRequest)
    }
}
