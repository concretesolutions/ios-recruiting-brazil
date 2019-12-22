//
//  MovieSearchViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, ViewCodable {
    var viewModel: SeachMoviesViewModel
    private lazy var moviesListViewController = MoviesListViewController(viewModel: viewModel.moviesViewModel, presentationManager: MovieListPresentationManager(
            modes:[.init(cellType: InformativeMovieCollectionViewCell.self, numberOfColumns: 1, heightFactor: 0.4)]
        )
    )

    private let moviesListLayoutGuide = UILayoutGuide()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController.init(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barStyle = .black

        return searchController
    }()
    
    lazy var searchOptionsSegmentedControl = UISegmentedControl(items: ["All", "Favorites"]).build {
        $0.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            $0.selectedSegmentTintColor = .appLightRed
        } else {
            $0.tintColor = .appLightRed
        }
    }
    
    init(viewModel: SeachMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addChild(moviesListViewController, inView: view, fillingAnchorable: moviesListLayoutGuide)
    }
    
    func buildHierarchy() {
        view.addSubview(searchOptionsSegmentedControl)
        view.addLayoutGuide(moviesListLayoutGuide)
    }
       
    func addConstraints() {
        searchOptionsSegmentedControl.layout.group
            .left(10).top(10).right(-10)
            .fill(to: view.safeAreaLayoutGuide)
        moviesListLayoutGuide.layout.top.equal(to: searchOptionsSegmentedControl.layout.bottom)
        moviesListLayoutGuide.layout.group.left.right.bottom.fill(to: view.safeAreaLayoutGuide)
    }
    
    func applyAditionalChanges() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.becomeFirstResponder()
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.resignFirstResponder()
        searchController.resignFirstResponder()
    }
}

extension MovieSearchViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
                return
        }

        viewModel.userUpdatedSearchQuery(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.userTappedSearchButton()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.userTappedCancelSearch()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}
