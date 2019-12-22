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
    private lazy var searchController: UISearchController = {
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
    private lazy var searchOptionsSegmentedControl = UISegmentedControl(items: ["All", "Favorites"]).build {
        $0.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            $0.selectedSegmentTintColor = .appLightRed
        } else {
            $0.tintColor = .appLightRed
        }
    }
    private lazy var suggestionsTableView = UITableView().build {
        $0.registerReusableCell(forCellType: UITableViewCell.self)
        $0.delegate = self
        $0.dataSource = self
        $0.tableFooterView = UIView(frame: .zero)
        $0.backgroundColor = .black
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
        view.addSubViews(searchOptionsSegmentedControl, suggestionsTableView)
        view.addLayoutGuide(moviesListLayoutGuide)
    }
       
    func addConstraints() {
        searchOptionsSegmentedControl.layout.group
            .left(10).top(10).right(-10)
            .fill(to: view.safeAreaLayoutGuide)
        moviesListLayoutGuide.layout.top.equal(to: searchOptionsSegmentedControl.layout.bottom)
        moviesListLayoutGuide.layout.group.left.right.bottom.fill(to: view.safeAreaLayoutGuide)
        suggestionsTableView.layout.fill(view: moviesListLayoutGuide, margin: 15)
    }
    
    func applyAditionalChanges() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.becomeFirstResponder()
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.resignFirstResponder()
        searchController.resignFirstResponder()
    }
    
    func observeViewModel() {
        viewModel.needReloadSuggestions = { [weak self] in
            DispatchQueue.main.async {
                self?.suggestionsTableView.reloadData()
            }
        }
        
        viewModel.needChangeSuggestionsVisibility = { [weak self] visible in
            DispatchQueue.main.async {
                self?.moviesListViewController.view.isHidden = visible
                self?.suggestionsTableView.isHidden = !visible
            }
        }
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

    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.userTappedCancelSearch()
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel(text: "Suggestions").build {
            $0.backgroundColor = .black
            $0.font = .systemFont(ofSize: 15, weight: .bold)
            $0.textColor = .appTextBlue
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSuggestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(forCellType: UITableViewCell.self, for: indexPath).build {
            $0.textLabel?.text = viewModel.suggestionAt(position: indexPath.row)
            $0.backgroundColor = .black
            $0.textLabel?.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let suggestion = tableView.cellForRow(at: indexPath)?.textLabel?.text else {
            return
        }
        
        searchController.searchBar.text = suggestion
    }
}
