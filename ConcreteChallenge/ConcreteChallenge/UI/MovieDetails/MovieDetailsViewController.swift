//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private let movieDetailsView = MovieDetailsView()
    private let movie: Movie

    weak var coordinator: Coordinator?

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = movieDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        movieDetailsView.setup(movie: movie)
    }

}
