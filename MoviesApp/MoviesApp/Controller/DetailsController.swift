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
    let viewModel: DetailsViewModel
    
    // MARK: - Inits
    init(crud: FavoriteCRUDInterface, selectedMovie: PresentableMovieInterface) {
        viewModel = DetailsViewModel(crud: crud,movie: selectedMovie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View cycle functions
    override func viewDidLoad() {
        self.view = screen
        
        navigationItem.title = "Details"
        
        viewModel.checkFavorite(movieID: viewModel.movie.id)
        screen.configure(detailedMovie: viewModel.movie, genreNames: viewModel.detailsGenres(), isFavorite: viewModel.isFavorite)
        screen.favButton.addTarget(self, action: #selector(addFavoriteAction), for: .touchUpInside)        
    }
    
    // MARK: - Input
    @objc func addFavoriteAction(){
        viewModel.addFavorite()
        screen.favButton.isSelected = viewModel.isFavorite
    }

}
