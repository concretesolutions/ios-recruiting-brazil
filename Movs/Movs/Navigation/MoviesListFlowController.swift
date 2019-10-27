//
//  MoviesListFlowController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MoviesListFlowController: UINavigationController {
    
    private lazy var moviesListViewModel: MoviesListViewModel = {
        let viewModel = MoviesListViewModel(withService: self.movieService)
        viewModel.onMovieSelected = self.onMovieSelected
        return viewModel
    }()
    
    private lazy var moviesListVC = MoviesListViewController(with: self.moviesListViewModel)
    private lazy var movieService = TMDBMovieService.shared
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [self.moviesListVC]
        
        self.navigationBar.barTintColor = UIColor.appYellow
        self.navigationBar.tintColor = UIColor.appDarkBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onMovieSelected(_ cellViewModel: MovieCellViewModel) {
        let detailsViewModel = MovieDetailsViewModel(with: self.movieService, posterImg: cellViewModel.posterImage, andMovie: cellViewModel.movie)
        let detailsVC = MovieDetailsViewController()
        detailsVC.viewModel = detailsViewModel
        
        self.pushViewController(detailsVC, animated: true)
    }
}
