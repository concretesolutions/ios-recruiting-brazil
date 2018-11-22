//
//  FavouriteMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

protocol MovieFilterDelegate {
    var filter: Filter { get set }
}

class FavouriteMoviesViewController: UIViewController, MovieFilterDelegate {
    
    //MARK: - Properties
    // Interface
    let tableView = FavouriteMoviesTableView()
    var tableViewDelegate: FavouriteMoviesTableViewDelegate?
    var tableViewDataSource: FavouriteMoviesTableViewDataSource?
    // Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    // Data
    let db = RealmManager.shared
    var filter = Filter()
    var searchedMovies = [Movie]()
    var favouriteMovies = [Movie]()
    
    //FIXME: interface
    lazy var tableHeaderContentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Design.colors.dark
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var removeFilterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Remove Filter", for: .normal)
        button.setTitleColor(Design.colors.mainYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - UI States Control
    fileprivate enum PresentationState {
        case withFilter
        case withoutFilter
    }
    
    fileprivate var presentationState: PresentationState = .withoutFilter {
        didSet {
            DispatchQueue.main.async {
                self.updatePresentation(state: self.presentationState)
            }
        }
    }
    
    //MAEK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationState = filter.isEmpty() ? .withoutFilter : .withFilter
        setupView()
        getFavouriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentationState = filter.isEmpty() ? .withoutFilter : .withFilter
        getFavouriteMovies()
        setupSearchBar()
    }
    
    //MARK: - Setup
    func setupDesign() {
        view.backgroundColor = Design.colors.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(pushFilterTableViewController))
        navigationController?.navigationBar.tintColor = Design.colors.dark
        navigationController?.navigationBar.barTintColor = Design.colors.mainYellow
    }
    
    func setupTableView(with movies: [Movie]) {
        let filteredMovies = applyFilter(movies)
        tableViewDataSource = FavouriteMoviesTableViewDataSource(movies: filteredMovies, tableView: tableView)
        tableView.dataSource = tableViewDataSource
        
        tableViewDelegate = FavouriteMoviesTableViewDelegate(movies: filteredMovies, delegate: self)
        tableView.delegate = tableViewDelegate
        
        tableView.reloadData()
    }
    
    //MARK: - UI States handlers
    fileprivate func updatePresentation(state: PresentationState) {
        
        switch state {
        case .withFilter:
            tableView.tableHeaderView = tableHeaderContentView
        case .withoutFilter:
            tableView.tableHeaderView = nil
        }
        
        if searchBarIsEmpty() {
            setupTableView(with: favouriteMovies)
        } else {
            setupTableView(with: searchedMovies)
        }
        
        setupConstraints()
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    //MARK: - Realm
    func getFavouriteMovies() {
        favouriteMovies.removeAll()
        db.getAll(MovieRlm.self).forEach({ favouriteMovies.append(Movie($0)) })
        setupTableView(with: favouriteMovies)
    }
    
    //MARK: - Navigation
    @objc
    func pushFilterTableViewController() {
        let filterVC = FilterTableViewController(delegate: self, for: favouriteMovies)
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
    }
    
}

//MARK: - MovieSelectionDelegate
extension FavouriteMoviesViewController: MovieSelectionDelegate {
    func didSelect(movie: Movie) {
        let movieVC = MovieDetailTableViewController(movie: movie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    func unfavouriteSelected(movie: Movie, indexPath: IndexPath) {
        if let deleteMovie = db.get(MovieRlm.self, withPrimaryKey: movie.id) {
            db.delete(deleteMovie)
            tableViewDataSource?.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print("Deleted from Realm")
        }
    }
}

//MARK: - UISearchBarDelegate
extension FavouriteMoviesViewController: UISearchBarDelegate {
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.searchController?.isActive = true
        definesPresentationContext = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBarIsEmpty() {
            setupTableView(with: favouriteMovies)
        } else {
            searchForContentContainingText(searchText)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBarIsEmpty() {
            setupTableView(with: favouriteMovies)
        } else {
            setupTableView(with: searchedMovies)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setupTableView(with: favouriteMovies)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func searchForContentContainingText(_ searchText: String) {
        searchedMovies = favouriteMovies.filter({$0.title.lowercased().contains(searchText.lowercased())})
        setupTableView(with: searchedMovies)
    }
    
}

//MARK: - Filter
extension FavouriteMoviesViewController {
    
    func applyFilter(_ movies: [Movie]) -> [Movie] {
        if filter.isEmpty() {
            return movies
        }
        
        let filteredMovies = movies.filter { (movie) -> Bool in
            var matchYear = false
            var matchGenre = false
            if let filterYear = filter.releaseYear {
                matchYear = movie.releaseYear == filterYear
            }
            if let filterGenre = filter.genre {
                matchGenre = movie.genres.contains {$0.name?.lowercased() == filterGenre.lowercased()}
            }
            return matchYear || matchGenre
        }
        return filteredMovies
    }
    
    @objc
    func removeFilter() {
        filter.clear()
        presentationState = .withoutFilter
    }
    
}

//MARK: - CodeView
extension FavouriteMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        tableHeaderContentView.addSubview(removeFilterButton)
    }
    
    func setupConstraints() {
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        if tableView.tableHeaderView != nil {
            tableHeaderContentView.snp.removeConstraints()
            tableHeaderContentView.snp.makeConstraints { (make) in
                make.width.equalTo(self.tableView.snp.width)
            }
            
            removeFilterButton.snp.removeConstraints()
            removeFilterButton.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().inset(5)
            }            
        }
    }
    
    func setupAdditionalConfiguration() {
        setupDesign()
    }
    
}

