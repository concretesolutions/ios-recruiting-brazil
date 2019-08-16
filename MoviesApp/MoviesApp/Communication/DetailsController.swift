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
    
    
    override func viewDidLoad() {
        self.view = screen
        
        screen.configure(detailedMovie: viewModel.movie!, genreNames: viewModel.detailsGenres())
      
        let favoriteButton = UIBarButtonItem(image: UIImage(named: viewModel.checkFavorite(movieID: viewModel.movie!.id)), style: .plain, target: self, action: #selector(addFavoriteAction))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func addFavoriteAction(){
        viewModel.addFavorite()
    }
}
