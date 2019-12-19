//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private var viewModel: MovieDetailsViewModel
    private lazy var screen: MovieDetailsView = {
        let screen = MovieDetailsView(withViewModel: self.viewModel)
        return screen
    }()

    required init(withMovieViewModel viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = screen
    }

}
