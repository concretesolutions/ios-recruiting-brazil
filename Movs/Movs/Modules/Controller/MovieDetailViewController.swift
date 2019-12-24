//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 08/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - Model

    private var movie: Movie

    // MARK: - Screen

    private lazy var screen = MovieDetailScreen()

    // MARK: - Initializers

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        self.screen.configure(with: self.movie)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movie"
        self.navigationItem.largeTitleDisplayMode = .never
    }

    override func viewWillAppear(_ animated: Bool) {
        self.screen.configureHeartImage()
    }
}
