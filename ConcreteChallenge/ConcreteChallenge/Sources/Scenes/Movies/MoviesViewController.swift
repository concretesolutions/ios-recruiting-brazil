//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController, ViewCode, MoviesDisplayLogic {
    private lazy var worker: MoviesWorker = MoviesWorker()

    private lazy var presenter: MoviesPresenter = MoviesPresenter(moviesDisplayLogic: self)

    private lazy var interactor: MoviesBusinessLogic = {
        return MoviesInteractor(worker: worker, presenter: presenter)
    }()

    private let galleryItemView = GalleryItemView()

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        loadMovies()
    }

    override func viewDidLayoutSubviews() {
        galleryItemView.backgroundColor = .red
    }

    // MARK: - ViewCode conforms

    func setupHierarchy() {
        let anchorConstraint = CGFloat(16)
        let horizontalItemsCount = CGFloat(2)
        let heightCell = (view.safeAreaLayoutGuide.layoutFrame.size.height - anchorConstraint) / 2.5
        let widthCell = (view.safeAreaLayoutGuide.layoutFrame.size.width - anchorConstraint * (horizontalItemsCount + 1)) / horizontalItemsCount

        view.addSubview(galleryItemView, constraints: [
            galleryItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: anchorConstraint),
            galleryItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: anchorConstraint),
            galleryItemView.heightAnchor.constraint(equalToConstant: heightCell),
            galleryItemView.widthAnchor.constraint(equalToConstant: widthCell),
        ])
    }

    func setupConstraints() { }

    func setupConfigurations() {
        view.backgroundColor = .white
    }

    // MARK: - MoviesDisplayLogic conforms

    func displayMoviesItems(viewModel: MoviesModels.MoviesItems.ViewModel) {
        print(viewModel.moviesResponse)
    }

    func displayMoviesError() { }

    // MARK: - Private functions

    private func loadMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        interactor.getMovies(request: MoviesModels.MoviesItems.Request(language: language, page: page))
    }
}
