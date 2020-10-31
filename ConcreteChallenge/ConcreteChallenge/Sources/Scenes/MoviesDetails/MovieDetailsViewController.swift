//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController, MovieDetailsDisplayLogic {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: movie.imageURL))

        return imageView
    }()

    private lazy var moviesDetailsInfoListView = InfoListTableViewFactory.makeTableView(movie: movie)

    // MARK: - Private constants

    private let movie: Movie

    private let interactor: MovieDetailsBusinessLogic

    // MARK: - Initializers

    init(movie: Movie, interactor: MovieDetailsBusinessLogic) {
        self.movie = movie
        self.interactor = interactor

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

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = Strings.movie.localizable
    }

    // MARK: - Private functions

    private func setupLayout() {
        setupNavigationBar()

        view.addSubview(imageView, constraints: [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])

        view.addSubview(moviesDetailsInfoListView, constraints: [
            moviesDetailsInfoListView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            moviesDetailsInfoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            moviesDetailsInfoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            moviesDetailsInfoListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])

        view.backgroundColor = .white
    }
}
