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
   
    // MARK: - Subscribers
    
    internal var backdropSubscriber: AnyCancellable?
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.screen.titleLabel.text = self.viewModel.title
        self.view = self.screen
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: MovieDetailsControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.bind(to: self.viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.backdropSubscriber?.cancel()
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: MovieDetailsControllerViewModel) {
        self.backdropSubscriber = viewModel.$backdropImage
            .receive(on: RunLoop.main)
            .sink(receiveValue: { image in
                self.screen.backdrop.image = image
            })
    }
}
