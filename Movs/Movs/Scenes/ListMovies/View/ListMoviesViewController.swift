//
//  ListMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesDisplayLogic: class {
    func displayMovies(viewModel: ListMovies.ViewModel.Success)
    func displayError(viewModel: ListMovies.ViewModel.Error)
}

class ListMoviesViewController: UIViewController {
    
    // MARK: - Variables
    // Initial configuration
    var interactor: ListMoviesBusinessLogic?
    let movieCellReuseIdentifier = "PopularMovieTableViewCell"
    let detailMovieSegue = "detailMovie"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
   
    // Auxiliar
    var page: Int = 1
    var fetchingMovies = false
    var isSearchBarActive: Bool = false
    var isEditingSearchBar: Bool = false
    var viewError: MovieListErrorView?
    
    typealias MoviePosition = [Int: Int]
    var moviesRanking = Set<MoviePosition>()
    var moviesRanking2 = Set<Int>()
    var moviesRanking3 = [Int]()
    
    // Data
    var movies = [ListMovies.ViewModel.PopularMoviesFormatted]()
    /// Data filtered from search bar
    var moviesFiltered = [ListMovies.ViewModel.PopularMoviesFormatted]()
    var favoriteMovies = [MovieDetailed]()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ListMoviesSceneConfigurator.inject(dependenciesFor: self)
        // Start presenting the first page
        let request = ListMovies.Request(page: page)
        interactor?.fetchPopularMovies(request: request)
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = FavoriteMoviesWorker.shared.getFavoriteMovies()
        tableView.reloadData()
    }

    // MARK: - Setup
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.view.tintColor = .darkGray
        navigationController?.view.backgroundColor = .white
        navigationItem.title = "Mais populares"
        setSearchButton()
    }
    // Add a Search button and icon into the navigation bar
    private func setSearchButton() {
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "search_icon"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        searchButton.addTarget(self, action: #selector(self.searchForMovie), for: .touchUpInside)
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        navigationItem.setRightBarButton(searchBarButton, animated: true)
    }

    // MARK: - Routing
    /**
     Going to DetailMovies.
     The screen should know what is the id of the movie to do it's own request on server
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailMovieSegue) {
            let viewController = segue.destination as! DetailMoviesViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let movieId = movies[indexPath!.row].id
            viewController.movieId = movieId
        }
    }
    
    // MARK: - Actions
    @objc private func searchForMovie(){
        updateSearchBar()
    }
    
    func updateSearchBar() {
        if isSearchBarActive {
            hideSearchBar()
        } else {
            showSearchBar()
        }
    }
    
    func hideSearchBar() {
        isSearchBarActive = false
        tableViewTopConstraint.constant = 0
        searchBar.endEditing(true)
    }
    
    func showSearchBar() {
        isSearchBarActive = true
        tableViewTopConstraint.constant = searchBar.frame.height
    }
}


// MARK: - Display Logic
extension ListMoviesViewController: ListMoviesDisplayLogic {
    
    func displayMovies(viewModel: ListMovies.ViewModel.Success) {
        movies.append(contentsOf: viewModel.movies)
        fetchingMovies = false
        // This is done to have a set of data to manipulate while presenting only the filtered data
        moviesFiltered = movies
        tupleOfPosition(movies: viewModel.movies)
        tableView.reloadData()
    }
    
    func tupleOfPosition(movies: [ListMovies.ViewModel.PopularMoviesFormatted]) {
        for movie in movies {
            let position: MoviePosition = [movie.id: moviesRanking.count + 1]
            moviesRanking.insert(position)
        }
    }
    
    func displayError(viewModel: ListMovies.ViewModel.Error) {
        // This variable is used due to the behavior of the Cancel button in the search bar.
        // If the view is full screen, the ViewError is the first responder and the button cannot be clicked
        let yDistance = tableViewTopConstraint.constant + searchBar.layer.frame.height
        let frame = CGRect(x: 0, y: yDistance, width: view.frame.width, height: view.frame.height)
        viewError = MovieListErrorView(frame: frame, image: viewModel.image!, message: viewModel.message)
        if viewModel.errorType == FetchError.networkFailToConnect {
            tableView.isHidden = true
            searchBar.isHidden = true
        }
        view.addSubview(viewError!)
    }

}
