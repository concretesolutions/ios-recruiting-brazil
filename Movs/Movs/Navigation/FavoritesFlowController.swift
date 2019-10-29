//
//  FavoritesFlowController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class FavoritesFlowController: UINavigationController {

    private lazy var favoritesListViewModel: FavoritesListViewModel = {
        let viewModel = FavoritesListViewModel(withService: self.movieService)
        viewModel.onMovieSelected = self.onMovieSelected
        return viewModel
    }()
    private lazy var moviesListVC = FavoritesListViewController(with: self.favoritesListViewModel)
    private var movieService: MovieServiceProtocol
    
    init(withService service: MovieServiceProtocol) {
        self.movieService = service
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = [self.moviesListVC]
        
        self.navigationBar.barTintColor = UIColor.appYellow
        self.navigationBar.tintColor = UIColor.appDarkBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onMovieSelected(_ cellViewModel: FavoriteMovieCellViewModel) {
        let detailsViewModel = MovieDetailsViewModel(with: self.movieService, andMovie: cellViewModel.movie)
        let detailsVC = MovieDetailsViewController()
        detailsVC.viewModel = detailsViewModel
        
        self.pushViewController(detailsVC, animated: true)
    }
    
}
