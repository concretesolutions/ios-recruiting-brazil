//
//  DetailsController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    let screen = DetailsView()
    let viewModel = DetailsViewModel()
    
    let favoriteButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        self.view = screen
        
        viewModel.checkFavorite(movieID: viewModel.movie.id)
        screen.configure(detailedMovie: viewModel.movie, genreNames: viewModel.detailsGenres(), isFavorite: viewModel.isFavorite)
        
        screen.favButton.addTarget(self, action: #selector(addFavoriteAction), for: .touchUpInside)        
    }
    
    @objc func addFavoriteAction(){
        print("adentrou")
        viewModel.addFavorite()
        screen.favButton.isSelected = viewModel.isFavorite
    }

}
