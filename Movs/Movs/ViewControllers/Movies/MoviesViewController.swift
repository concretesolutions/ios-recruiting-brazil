//
//  MoviesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    enum Constants {
        static let nibName = "MoviesViewController"
        static let title = "Movies"
        static let cellIdentifier = "MoviesCollectionViewCell"
        static let cellSpacing: CGFloat = 5.0
    }

    @IBOutlet var popularCollectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)

    private var presenter: MoviesPresenter!

    init() {
        super.init(nibName: Constants.nibName, bundle: nil)
        title = Constants.title
        tabBarItem.title = Constants.title
        tabBarItem.image = UIImage(named: "tabItemList")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesPresenter()
        presenter.view = self
        setupSearchBar()
        setupCollectionView()
    }

    private func setupSearchBar() {
        searchController.searchBar.placeholder = "Search movie"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }

    private func setupCollectionView() {
        popularCollectionView.register(
            UINib(nibName: Constants.cellIdentifier, bundle: nil),
            forCellWithReuseIdentifier: Constants.cellIdentifier
        )
        popularCollectionView.contentInset = UIEdgeInsets(
            top: Constants.cellSpacing,
            left: Constants.cellSpacing,
            bottom: Constants.cellSpacing,
            right: Constants.cellSpacing
        )
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        )
        if let moviesCell = cell as? MoviesCollectionViewCell {
            // TODO: setup cell
            return moviesCell
        }
        fatalError("Cell not configured")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching() {
            return 3
        }
        return 100
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.onMovieSelected()
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2) - 8
        return CGSize(width: cellWidth, height: cellWidth + 30)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            print("Is active")
        } else {
            print("Is NOT active")
        }
        popularCollectionView.reloadData()
    }

    /**
     Return whether the user is searching for a specific movie.
     */
    func isSearching() -> Bool {
        if let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) {
            return !text.isEmpty
        }
        return false
    }
}

extension MoviesViewController: MoviesView {
    /**
     Fetches and displays the details of the selected movie.
     */
    func openMovieDetails() {
        let movieDetailsViewController = MovieDetailsViewController()
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
