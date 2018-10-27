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
    
    // Initial configuration
    var interactor: ListMoviesBusinessLogic?
    private var page: Int = 1
    let movieCellReuseIdentifier = "PopularMovieTableViewCell"
    let detailMovieSegue = "detailMovie"
    
    
    @IBOutlet weak var tableView: UITableView!

    // Data
    var movies = [PopularMovie]()
    let moviesLimitToPresent = 50
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ListMoviesSceneConfigurator.inject(dependenciesFor: self)
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Start presenting the first page
        let request = ListMovies.Request(page: 1)
        interactor?.fetchPopularMovies(request: request)
    }

    // MARK: - Setup
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.view.tintColor = .darkGray
        navigationController?.view.backgroundColor = .white
        navigationItem.title = "Mais populares"
    }

    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailMovieSegue) {
            let viewController = segue.destination as! DetailMoviesViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let movieId = movies[indexPath!.row].id
            viewController.movieId = movieId
        }
    }
    
}

extension ListMoviesViewController: ListMoviesDisplayLogic {
    
    func displayMovies(viewModel: ListMovies.ViewModel.Success) {
        movies = viewModel.movies
        tableView.reloadData()
    }
    
    func displayError(viewModel: ListMovies.ViewModel.Error) {
        
    }

}

extension ListMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailMovieSegue, sender: nil)
    }
    
}

