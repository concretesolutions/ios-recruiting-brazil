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
        
        if let backdropPath = self.viewModel.backdropPath {
            self.screen.backdrop.download(imageURL: "https://image.tmdb.org/t/p/w780\(backdropPath)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.screen.titleLabel.text = self.viewModel.title
        self.view = self.screen
    }
}
