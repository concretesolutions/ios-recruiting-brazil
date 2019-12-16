//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    internal let screen = MovieDetailsViewScreen()
    internal var viewModel: MovieDetailsControllerViewModel
    internal var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: MovieDetailsControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        if let backdropPath = self.viewModel.movieViewModel.backdropPath {
            self.screen.backdrop.download(imageURL: "https://image.tmdb.org/t/p/w780\(backdropPath)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        let favoriteStatus = self.viewModel.movieViewModel.getFavoriteStatus()
        
        self.screen.titleLabel.text = self.viewModel.movieViewModel.title
        self.screen.favoriteButton.setFavorited(favoriteStatus)
        self.screen.favoriteButton.addTarget(self, action: #selector(self.didTapFavorite(_: )), for: .touchUpInside)
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen.detailsTableView.delegate = self
        self.screen.detailsTableView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.coordinatorDelegate?.finish()
    }
    
    // MARK: - Actions
    
    @objc func didTapFavorite(_ sender: FavoriteButton) {
        sender.setFavorited(!sender.favorited)
        
        if sender.favorited == true {
            self.viewModel.movieViewModel.addToFavorites()
        } else {
            self.viewModel.movieViewModel.removeFromFavorites()
        }
    }
}
