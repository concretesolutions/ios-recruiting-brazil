//
//  FavoritesViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func onFetchLocalMoviesSuccess(viewModel: Favorites.FetchLocalMovies.ViewModel)
    func displayMoviesError()
    func displaySearchError(searchText: String)
}

final class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    private lazy var horizontalItemView: HorizontalInfoListItemView = HorizontalInfoListFactory.makeItem()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalItemView, errorView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Private variables

    private var localMovies: [Movie] = []

    // MARK: - Private constants

    private let interactor: FavoritesBusinessLogic

    private let errorView: ErrorView = ErrorViewFactory.make()

    // MARK: - Initializers

    init(interactor: FavoritesBusinessLogic) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        fetchLocalMovies()
    }

    // MARK: - FavoritesDisplayLogic conforms

    func onFetchLocalMoviesSuccess(viewModel: Favorites.FetchLocalMovies.ViewModel) {
        localMovies = viewModel.movies
        print(localMovies)
    }

    func displayMoviesError() { }

    func displaySearchError(searchText: String) { }

    // MARK: - Private functions

    private func setupLayout() {
        view.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            stackView.heightAnchor.constraint(equalToConstant: 180)
        ])

        view.backgroundColor = .white
    }

    private func fetchLocalMovies() {
        interactor.fetchLocalMovies()
    }
}
