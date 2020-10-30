//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let movie: Movie

    // MARK: - Initializers

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    // MARK: - Private functions

    private func setupLayout() {
        setupNavigationBar()
        view.backgroundColor = .white
    }

    private func setupNavigationBar() {
        title = Strings.movie.localizable
        print(movie)
    }
}
